import FoundationModels

@Generable(description: "An introduction to a language lesson topic")
struct LessonIntroduction {
    @Guide(description: "A warm greeting setting context for this lesson. 1-2 sentences.")
    var greeting: String

    @Guide(description: "What the learner will master and why it matters. Reference prior knowledge. 2-3 sentences.")
    var overview: String

    @Guide(description: "A cognate or familiar word bridging the native and target languages")
    var bridgeWord: String

    @Guide(description: "How the bridge word connects the two languages. 1 sentence.")
    var bridgeExplanation: String
}

@Generable(description: "A language learning exercise using the Thinking Method")
struct TutorExercise {
    @Guide(description: "Brief concept explanation connecting to what the learner knows via cognates or patterns. 1-2 sentences.")
    var conceptExplanation: String

    @Guide(description: "The sentence to translate, in the learner's native language")
    var sourcePhrase: String

    @Guide(description: "The correct translation in the target language")
    var correctTranslation: String

    @Guide(description: "A Socratic hint helping the learner derive the answer from patterns. Do not give the answer.")
    var thinkingHint: String

    @Guide(description: "Key vocabulary as comma-separated word=translation pairs")
    var vocabularyPairs: String
}

@Generable(description: "Feedback on a language learner's translation attempt")
struct TutorFeedback {
    @Guide(description: "Whether the answer is correct, partial, or incorrect")
    var evaluation: String

    @Guide(description: "Encouraging feedback explaining what was right or wrong, referencing the grammar pattern. 2-3 sentences.")
    var explanation: String

    @Guide(description: "The correct answer")
    var correctedTranslation: String

    @Guide(description: "A follow-up sentence to translate that reinforces the same pattern, in the native language")
    var reinforcementPhrase: String
}

@Generable(description: "A summary shown when a learner completes a lesson")
struct LessonSummary {
    @Guide(description: "Congratulatory message reflecting their performance. 1-2 sentences.")
    var congratulation: String

    @Guide(description: "Comma-separated list of key grammar patterns practiced")
    var patternsPracticed: String

    @Guide(description: "One specific area to focus on next, phrased positively. 1 sentence.")
    var improvementTip: String
}
