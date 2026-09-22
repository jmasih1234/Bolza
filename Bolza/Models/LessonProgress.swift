import SwiftData
import Foundation

@Model
final class LessonProgress {
    var id: UUID = UUID()
    var startedAt: Date = Date()
    var completedAt: Date?
    var exercisesCompleted: Int = 0
    var exercisesCorrect: Int = 0
    var xpAwarded: Int = 0

    var lessonNode: LessonNode?

    @Transient
    var scorePercent: Int {
        guard exercisesCompleted > 0 else { return 0 }
        return (exercisesCorrect * 100) / exercisesCompleted
    }

    init() {}
}
