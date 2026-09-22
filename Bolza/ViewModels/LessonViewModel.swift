import Observation
import SwiftData
import Foundation

@Observable
final class LessonViewModel {
    enum LessonPhase: Equatable {
        case loading
        case intro(LessonIntroduction)
        case exercise(TutorExercise, index: Int)
        case awaitingInput(TutorExercise)
        case evaluating
        case feedback(TutorFeedback, exercise: TutorExercise)
        case summary(LessonSummary)
        case error(String)

        static func == (lhs: LessonPhase, rhs: LessonPhase) -> Bool {
            switch (lhs, rhs) {
            case (.loading, .loading), (.evaluating, .evaluating):
                return true
            case (.error(let a), .error(let b)):
                return a == b
            default:
                return false
            }
        }
    }

    var phase: LessonPhase = .loading
    var userInput: String = ""
    var exerciseResults: [(phrase: String, userAnswer: String, correct: Bool)] = []
    var currentExerciseIndex: Int = 0
    let totalExercises = AppConstants.exercisesPerLesson

    private let tutorService: TutorService
    private let targetLanguage: TargetLanguage
    private let nativeLanguage: NativeLanguage
    private let proficiency: ProficiencyLevel
    private let topicKey: String
    private let previousTopics: [String]

    init(tutorService: TutorService, node: LessonNode, profile: UserProfile) {
        self.tutorService = tutorService
        self.targetLanguage = node.course?.language ?? .spanish
        self.nativeLanguage = profile.nativeLanguage
        self.proficiency = node.course?.proficiency ?? .beginner
        self.topicKey = node.topicKey
        self.previousTopics = node.course?.sortedNodes
            .filter { $0.isCompleted && $0.orderIndex < node.orderIndex }
            .map(\.topicKey) ?? []
    }

    func startLesson() async {
        phase = .loading
        do {
            let intro = try await tutorService.generateLessonIntro(
                targetLanguage: targetLanguage,
                nativeLanguage: nativeLanguage,
                proficiency: proficiency,
                topicKey: topicKey,
                previousTopics: previousTopics
            )
            phase = .intro(intro)
        } catch {
            phase = .error("Could not start lesson: \(error.localizedDescription)")
        }
    }

    func nextExercise() async {
        phase = .loading
        do {
            let context = exerciseResults.map {
                "\($0.phrase): \($0.correct ? "correct" : "incorrect")"
            }.joined(separator: ". ")

            let exercise = try await tutorService.generateExercise(
                targetLanguage: targetLanguage,
                nativeLanguage: nativeLanguage,
                proficiency: proficiency,
                topicKey: topicKey,
                lessonContext: context
            )
            phase = .exercise(exercise, index: currentExerciseIndex)
        } catch {
            phase = .error("Could not generate exercise: \(error.localizedDescription)")
        }
    }

    func readyToAnswer(_ exercise: TutorExercise) {
        phase = .awaitingInput(exercise)
    }

    func submitAnswer(_ exercise: TutorExercise) async {
        let attempt = userInput.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !attempt.isEmpty else { return }

        phase = .evaluating
        do {
            let feedback = try await tutorService.evaluateAttempt(
                targetLanguage: targetLanguage,
                nativeLanguage: nativeLanguage,
                userAttempt: attempt,
                correctAnswer: exercise.correctTranslation,
                sourcePhrase: exercise.sourcePhrase
            )
            let isCorrect = feedback.evaluation == "correct"
            exerciseResults.append((
                phrase: exercise.sourcePhrase,
                userAnswer: attempt,
                correct: isCorrect
            ))
            phase = .feedback(feedback, exercise: exercise)
        } catch {
            phase = .error("Could not evaluate answer: \(error.localizedDescription)")
        }
    }

    func proceedAfterFeedback() async {
        currentExerciseIndex += 1
        userInput = ""
        if currentExerciseIndex >= totalExercises {
            await generateSummary()
        } else {
            await nextExercise()
        }
    }

    private func generateSummary() async {
        phase = .loading
        do {
            let summary = try await tutorService.generateLessonSummary(
                targetLanguage: targetLanguage,
                exerciseResults: exerciseResults.map { ($0.phrase, $0.correct) }
            )
            phase = .summary(summary)
        } catch {
            phase = .error("Could not generate summary: \(error.localizedDescription)")
        }
    }

    var correctCount: Int {
        exerciseResults.filter(\.correct).count
    }

    var xpEarned: Int {
        var xp = correctCount * AppConstants.baseXPPerExercise
        if correctCount == totalExercises {
            xp += AppConstants.bonusXPForPerfect
        }
        return xp
    }

    func completeLesson(node: LessonNode, modelContext: ModelContext) {
        guard let course = node.course else { return }

        node.isCompleted = true
        node.xpEarned = xpEarned
        node.bestScore = max(node.bestScore, (correctCount * 100) / totalExercises)
        node.completedAt = Date()

        // Unlock next node
        if let nextNode = course.lessonNodes
            .sorted(by: { $0.orderIndex < $1.orderIndex })
            .first(where: { $0.orderIndex == node.orderIndex + 1 }) {
            nextNode.isUnlocked = true
        }

        course.totalXP += xpEarned

        // Record progress
        let progress = LessonProgress()
        progress.startedAt = Date()
        progress.completedAt = Date()
        progress.exercisesCompleted = totalExercises
        progress.exercisesCorrect = correctCount
        progress.xpAwarded = xpEarned
        progress.lessonNode = node
        modelContext.insert(progress)

        // Update daily streak
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())

        if let profile = course.userProfile {
            if let existingStreak = profile.streaks.first(where: {
                calendar.startOfDay(for: $0.date) == today
            }) {
                existingStreak.lessonsCompleted += 1
                existingStreak.xpEarned += xpEarned
            } else {
                let streak = DailyStreak(date: today)
                streak.lessonsCompleted = 1
                streak.xpEarned = xpEarned
                streak.userProfile = profile
                modelContext.insert(streak)
            }
        }

        try? modelContext.save()
    }
}
