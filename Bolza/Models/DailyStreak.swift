import SwiftData
import Foundation

@Model
final class DailyStreak {
    var id: UUID = UUID()
    var date: Date = Date()
    var lessonsCompleted: Int = 0
    var xpEarned: Int = 0

    var userProfile: UserProfile?

    init(date: Date) {
        self.date = Calendar.current.startOfDay(for: date)
    }
}
