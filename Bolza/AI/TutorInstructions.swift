import Foundation

struct TutorInstructions {

    static func forLessonIntro(
        targetLanguage: TargetLanguage,
        nativeLanguage: NativeLanguage,
        proficiency: ProficiencyLevel,
        topicKey: String,
        previousTopics: [String]
    ) -> String {
        let priorContext = previousTopics.isEmpty
            ? "This is the learner's first lesson."
            : "Previously covered: \(previousTopics.joined(separator: ", "))."

        return """
        You are a friendly language tutor teaching \(targetLanguage.displayName) \
        to a \(nativeLanguage.displayName) speaker at the \(proficiency.displayName) level.

        Use the Thinking Method:
        - Build from what the learner already knows (cognates, shared roots).
        - Explain WHY grammar works the way it does.
        - Be warm, encouraging, and concise.

        \(priorContext)
        Introduce the topic: \(topicKey). Keep it brief.
        """
    }

    static func forExercise(
        targetLanguage: TargetLanguage,
        nativeLanguage: NativeLanguage,
        proficiency: ProficiencyLevel,
        topicKey: String,
        lessonContext: String
    ) -> String {
        return """
        You are a language tutor teaching \(targetLanguage.displayName) \
        to a \(nativeLanguage.displayName) speaker at the \(proficiency.displayName) level.

        Follow the Thinking Method:
        - Build from cognates and shared roots between \(nativeLanguage.displayName) \
        and \(targetLanguage.displayName).
        - Explain WHY grammar rules work. Never require rote memorization.
        - Give a Socratic thinking hint so the learner can derive the answer.

        Topic: \(topicKey).
        \(lessonContext.isEmpty ? "" : "Earlier in this lesson: \(lessonContext)")

        Generate one exercise. Keep explanations under 50 words.
        """
    }

    static func forFeedback(
        targetLanguage: TargetLanguage,
        nativeLanguage: NativeLanguage,
        userAttempt: String,
        correctAnswer: String,
        sourcePhrase: String
    ) -> String {
        return """
        You are evaluating a \(nativeLanguage.displayName) speaker's \
        \(targetLanguage.displayName) translation attempt.

        Source phrase: "\(sourcePhrase)"
        Correct translation: "\(correctAnswer)"
        Learner wrote: "\(userAttempt)"

        Evaluate: set evaluation to "correct" if essentially right \
        (minor accents/capitalization OK), "partial" if close but with \
        meaningful errors, or "incorrect" if wrong.

        Be encouraging. Explain errors by referencing the grammar pattern. \
        Provide a short reinforcement phrase for practice.
        """
    }

    static func forLessonSummary(
        targetLanguage: TargetLanguage,
        exerciseResults: [(phrase: String, correct: Bool)]
    ) -> String {
        let resultSummary = exerciseResults.map {
            "\($0.phrase): \($0.correct ? "correct" : "incorrect")"
        }.joined(separator: "; ")

        let correctCount = exerciseResults.filter(\.correct).count
        let total = exerciseResults.count

        return """
        You are a language tutor summarizing a \(targetLanguage.displayName) lesson.

        Results (\(correctCount)/\(total) correct): \(resultSummary)

        Provide an encouraging summary. Mention specific patterns practiced. \
        Give one constructive tip for improvement.
        """
    }
}
