import Foundation

enum TargetLanguage: String, Codable, CaseIterable, Identifiable {
    case spanish, french, german, mandarin, english

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .spanish: "Spanish"
        case .french: "French"
        case .german: "German"
        case .mandarin: "Mandarin Chinese"
        case .english: "English"
        }
    }

    var flag: String {
        switch self {
        case .spanish: "\u{1F1EA}\u{1F1F8}"
        case .french: "\u{1F1EB}\u{1F1F7}"
        case .german: "\u{1F1E9}\u{1F1EA}"
        case .mandarin: "\u{1F1E8}\u{1F1F3}"
        case .english: "\u{1F1EC}\u{1F1E7}"
        }
    }

    var bcp47Code: String {
        switch self {
        case .spanish: "es"
        case .french: "fr"
        case .german: "de"
        case .mandarin: "zh-Hans"
        case .english: "en"
        }
    }

    var lessonTopics: [(topicKey: String, title: String, subtitle: String)] {
        switch self {
        case .spanish:
            return Self.spanishTopics
        case .french:
            return Self.frenchTopics
        case .german:
            return Self.germanTopics
        case .mandarin:
            return Self.mandarinTopics
        case .english:
            return Self.englishTopics
        }
    }

    private static let spanishTopics: [(topicKey: String, title: String, subtitle: String)] = [
        ("cognates_intro", "Cognates", "Words you already know"),
        ("greetings", "Greetings", "Hello and goodbye"),
        ("basic_verbs_ar", "Verb Basics", "-ar verbs in present"),
        ("basic_verbs_er_ir", "More Verbs", "-er and -ir verbs"),
        ("questions", "Questions", "Asking and answering"),
        ("negation", "Negation", "Saying no"),
        ("articles_gender", "Articles", "El, la, los, las"),
        ("adjectives", "Describing", "Colors, sizes, feelings"),
        ("possessives", "Possession", "My, your, their"),
        ("numbers_time", "Numbers & Time", "Counting and telling time"),
        ("prepositions", "Prepositions", "Location and direction"),
        ("ser_vs_estar", "Ser vs Estar", "Two ways to be"),
        ("past_tense_preterite", "Past Tense I", "What happened"),
        ("past_tense_imperfect", "Past Tense II", "What used to happen"),
        ("reflexive_verbs", "Reflexive Verbs", "Actions on yourself"),
        ("future_tense", "Future Tense", "What will happen"),
        ("conditional", "Conditional", "Would and could"),
        ("subjunctive_intro", "Subjunctive I", "Wishes and doubts"),
        ("commands", "Commands", "Telling others what to do"),
        ("conversation", "Conversation", "Putting it all together"),
    ]

    private static let frenchTopics: [(topicKey: String, title: String, subtitle: String)] = [
        ("cognates_intro", "Cognates", "Words you already know"),
        ("greetings", "Greetings", "Bonjour and au revoir"),
        ("articles_gender", "Articles", "Le, la, les, un, une"),
        ("basic_verbs_er", "Verb Basics", "-er verbs in present"),
        ("basic_verbs_ir_re", "More Verbs", "-ir and -re verbs"),
        ("questions", "Questions", "Asking and answering"),
        ("negation", "Negation", "Ne...pas and beyond"),
        ("adjectives", "Describing", "Agreement and placement"),
        ("possessives", "Possession", "Mon, ton, son"),
        ("numbers_time", "Numbers & Time", "Counting and telling time"),
        ("prepositions", "Prepositions", "Location and direction"),
        ("passe_compose", "Past Tense I", "Passe compose"),
        ("imparfait", "Past Tense II", "Imparfait"),
        ("reflexive_verbs", "Reflexive Verbs", "Se laver, se lever"),
        ("future_tense", "Future Tense", "What will happen"),
        ("conditional", "Conditional", "Would and could"),
        ("subjunctive_intro", "Subjunctive I", "Wishes and doubts"),
        ("pronouns", "Pronouns", "Y, en, and object pronouns"),
        ("commands", "Commands", "Imperatif"),
        ("conversation", "Conversation", "Putting it all together"),
    ]

    private static let germanTopics: [(topicKey: String, title: String, subtitle: String)] = [
        ("cognates_intro", "Cognates", "Words you already know"),
        ("greetings", "Greetings", "Hallo and Tschuss"),
        ("articles_cases", "Articles & Cases", "Der, die, das"),
        ("basic_verbs", "Verb Basics", "Regular verbs in present"),
        ("sein_haben", "Sein & Haben", "To be and to have"),
        ("questions", "Questions", "W-Fragen"),
        ("negation", "Negation", "Nicht and kein"),
        ("adjectives", "Describing", "Adjective endings"),
        ("accusative", "Accusative Case", "Direct objects"),
        ("dative", "Dative Case", "Indirect objects"),
        ("modal_verbs", "Modal Verbs", "Can, must, want"),
        ("separable_verbs", "Separable Verbs", "Aufstehen, ankommen"),
        ("past_perfekt", "Past Tense I", "Perfekt"),
        ("past_prateritum", "Past Tense II", "Prateritum"),
        ("prepositions", "Prepositions", "Two-way prepositions"),
        ("reflexive_verbs", "Reflexive Verbs", "Sich waschen"),
        ("future_tense", "Future Tense", "Werden + infinitive"),
        ("relative_clauses", "Relative Clauses", "Connecting ideas"),
        ("passive", "Passive Voice", "What is being done"),
        ("conversation", "Conversation", "Putting it all together"),
    ]

    private static let mandarinTopics: [(topicKey: String, title: String, subtitle: String)] = [
        ("tones_pinyin", "Tones & Pinyin", "The four tones"),
        ("greetings", "Greetings", "Ni hao and beyond"),
        ("basic_sentences", "Basic Sentences", "Subject-verb-object"),
        ("numbers", "Numbers", "Counting 1-100"),
        ("measure_words", "Measure Words", "Ge, ben, zhi"),
        ("questions", "Questions", "Ma and question words"),
        ("negation", "Negation", "Bu and mei"),
        ("time_expressions", "Time", "Today, yesterday, tomorrow"),
        ("location", "Location", "Zai and directions"),
        ("adjectives", "Describing", "Hen + adjective"),
        ("verbs_aspect", "Verb Aspects", "Le, guo, zhe"),
        ("comparison", "Comparison", "Bi and more/less"),
        ("modal_verbs", "Can & Want", "Neng, hui, xiang"),
        ("de_particles", "De Particles", "De, de, de"),
        ("complement_result", "Result Complements", "Verb + result"),
        ("passive_ba", "Ba Sentences", "Rearranging objects"),
        ("conditional", "Conditionals", "If and then"),
        ("measure_time", "Duration", "How long"),
        ("complex_sentences", "Complex Sentences", "Because, although"),
        ("conversation", "Conversation", "Putting it all together"),
    ]

    private static let englishTopics: [(topicKey: String, title: String, subtitle: String)] = [
        ("cognates_intro", "Cognates", "Words you may know"),
        ("greetings", "Greetings", "Hello and goodbye"),
        ("basic_verbs", "Verb Basics", "Simple present"),
        ("to_be", "To Be", "Am, is, are"),
        ("articles", "Articles", "A, an, the"),
        ("questions", "Questions", "Do, does, and Wh-"),
        ("negation", "Negation", "Don't and doesn't"),
        ("adjectives", "Describing", "Colors, sizes, feelings"),
        ("possessives", "Possession", "My, your, their, 's"),
        ("numbers_time", "Numbers & Time", "Counting and telling time"),
        ("prepositions", "Prepositions", "In, on, at, to"),
        ("past_simple", "Past Simple", "What happened"),
        ("past_continuous", "Past Continuous", "What was happening"),
        ("present_perfect", "Present Perfect", "Have done"),
        ("future", "Future", "Will and going to"),
        ("modals", "Modals", "Can, should, must"),
        ("conditionals", "Conditionals", "If sentences"),
        ("passive", "Passive Voice", "It was done"),
        ("phrasal_verbs", "Phrasal Verbs", "Look up, give in"),
        ("conversation", "Conversation", "Putting it all together"),
    ]
}

enum NativeLanguage: String, Codable, CaseIterable, Identifiable {
    case english, spanish, french, german, mandarin

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .english: "English"
        case .spanish: "Spanish"
        case .french: "French"
        case .german: "German"
        case .mandarin: "Mandarin Chinese"
        }
    }

    var flag: String {
        switch self {
        case .english: "\u{1F1EC}\u{1F1E7}"
        case .spanish: "\u{1F1EA}\u{1F1F8}"
        case .french: "\u{1F1EB}\u{1F1F7}"
        case .german: "\u{1F1E9}\u{1F1EA}"
        case .mandarin: "\u{1F1E8}\u{1F1F3}"
        }
    }
}

enum ProficiencyLevel: String, Codable, CaseIterable, Identifiable {
    case beginner, intermediate, advanced

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .beginner: "Beginner"
        case .intermediate: "Intermediate"
        case .advanced: "Advanced"
        }
    }

    var description: String {
        switch self {
        case .beginner: "I'm just starting out"
        case .intermediate: "I know some basics"
        case .advanced: "I can hold a conversation"
        }
    }

    var icon: String {
        switch self {
        case .beginner: "leaf"
        case .intermediate: "flame"
        case .advanced: "star"
        }
    }

    var startingLessonIndex: Int {
        switch self {
        case .beginner: 0
        case .intermediate: 8
        case .advanced: 14
        }
    }
}
