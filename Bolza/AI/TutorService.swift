import FoundationModels
import Observation

@Observable
final class TutorService {
    var isGenerating = false

    var isModelAvailable: Bool {
        SystemLanguageModel.default.isAvailable
    }

    func generateLessonIntro(
        targetLanguage: TargetLanguage,
        nativeLanguage: NativeLanguage,
        proficiency: ProficiencyLevel,
        topicKey: String,
        previousTopics: [String]
    ) async throws -> LessonIntroduction {
        isGenerating = true
        defer { isGenerating = false }

        let instructions = TutorInstructions.forLessonIntro(
            targetLanguage: targetLanguage,
            nativeLanguage: nativeLanguage,
            proficiency: proficiency,
            topicKey: topicKey,
            previousTopics: previousTopics
        )
        let session = LanguageModelSession(instructions: instructions)
        let response = try await session.respond(
            to: "Introduce the topic: \(topicKey)",
            generating: LessonIntroduction.self
        )
        return response.content
    }

    func generateExercise(
        targetLanguage: TargetLanguage,
        nativeLanguage: NativeLanguage,
        proficiency: ProficiencyLevel,
        topicKey: String,
        lessonContext: String
    ) async throws -> TutorExercise {
        isGenerating = true
        defer { isGenerating = false }

        let instructions = TutorInstructions.forExercise(
            targetLanguage: targetLanguage,
            nativeLanguage: nativeLanguage,
            proficiency: proficiency,
            topicKey: topicKey,
            lessonContext: lessonContext
        )
        let session = LanguageModelSession(instructions: instructions)
        let response = try await session.respond(
            to: "Generate the next exercise.",
            generating: TutorExercise.self
        )
        return response.content
    }

    func evaluateAttempt(
        targetLanguage: TargetLanguage,
        nativeLanguage: NativeLanguage,
        userAttempt: String,
        correctAnswer: String,
        sourcePhrase: String
    ) async throws -> TutorFeedback {
        isGenerating = true
        defer { isGenerating = false }

        let instructions = TutorInstructions.forFeedback(
            targetLanguage: targetLanguage,
            nativeLanguage: nativeLanguage,
            userAttempt: userAttempt,
            correctAnswer: correctAnswer,
            sourcePhrase: sourcePhrase
        )
        let session = LanguageModelSession(instructions: instructions)
        let response = try await session.respond(
            to: "Evaluate the learner's attempt.",
            generating: TutorFeedback.self
        )
        return response.content
    }

    func generateLessonSummary(
        targetLanguage: TargetLanguage,
        exerciseResults: [(phrase: String, correct: Bool)]
    ) async throws -> LessonSummary {
        isGenerating = true
        defer { isGenerating = false }

        let instructions = TutorInstructions.forLessonSummary(
            targetLanguage: targetLanguage,
            exerciseResults: exerciseResults
        )
        let session = LanguageModelSession(instructions: instructions)
        let response = try await session.respond(
            to: "Summarize the lesson.",
            generating: LessonSummary.self
        )
        return response.content
    }
}
