import SwiftData
import Foundation

@Model
final class LanguageCourse {
    var id: UUID = UUID()
    var languageRaw: String = TargetLanguage.spanish.rawValue
    var proficiencyRaw: String = ProficiencyLevel.beginner.rawValue
    var totalXP: Int = 0
    var enrolledAt: Date = Date()

    var userProfile: UserProfile?

    @Relationship(deleteRule: .cascade, inverse: \LessonNode.course)
    var lessonNodes: [LessonNode] = []

    @Transient
    var language: TargetLanguage {
        get { TargetLanguage(rawValue: languageRaw) ?? .spanish }
        set { languageRaw = newValue.rawValue }
    }

    @Transient
    var proficiency: ProficiencyLevel {
        get { ProficiencyLevel(rawValue: proficiencyRaw) ?? .beginner }
        set { proficiencyRaw = newValue.rawValue }
    }

    @Transient
    var currentLevel: Int {
        max(1, (totalXP / AppConstants.xpPerLevel) + 1)
    }

    @Transient
    var xpTowardNextLevel: Int {
        totalXP % AppConstants.xpPerLevel
    }

    @Transient
    var completedLessonCount: Int {
        lessonNodes.filter(\.isCompleted).count
    }

    @Transient
    var sortedNodes: [LessonNode] {
        lessonNodes.sorted { $0.orderIndex < $1.orderIndex }
    }

    @Transient
    var nextLesson: LessonNode? {
        sortedNodes.first { $0.isUnlocked && !$0.isCompleted }
    }

    init(language: TargetLanguage, proficiency: ProficiencyLevel) {
        self.languageRaw = language.rawValue
        self.proficiencyRaw = proficiency.rawValue
    }
}
