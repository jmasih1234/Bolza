import SwiftData
import Foundation

@Model
final class LessonNode {
    var id: UUID = UUID()
    var orderIndex: Int = 0
    var topicKey: String = ""
    var title: String = ""
    var subtitle: String = ""
    var isUnlocked: Bool = false
    var isCompleted: Bool = false
    var xpEarned: Int = 0
    var bestScore: Int = 0
    var completedAt: Date?

    var course: LanguageCourse?

    @Relationship(deleteRule: .cascade, inverse: \LessonProgress.lessonNode)
    var progressEntries: [LessonProgress] = []

    @Transient
    var nodeIcon: String {
        if isCompleted {
            return "checkmark.circle.fill"
        } else if isUnlocked {
            return "play.circle.fill"
        } else {
            return "lock.circle"
        }
    }

    init(orderIndex: Int, topicKey: String, title: String, subtitle: String) {
        self.orderIndex = orderIndex
        self.topicKey = topicKey
        self.title = title
        self.subtitle = subtitle
    }
}
