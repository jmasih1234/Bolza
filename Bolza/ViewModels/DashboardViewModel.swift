import Observation
import SwiftData
import Foundation

@Observable
final class DashboardViewModel {
    var currentStreak: Int = 0
    var todayXP: Int = 0
    var totalXP: Int = 0
    var currentLevel: Int = 1
    var xpTowardNextLevel: Int = 0
    var completedLessons: Int = 0
    var totalLessons: Int = 0

    func load(profile: UserProfile) {
        currentStreak = profile.currentStreak

        if let course = profile.activeCourse {
            totalXP = course.totalXP
            currentLevel = course.currentLevel
            xpTowardNextLevel = course.xpTowardNextLevel
            completedLessons = course.completedLessonCount
            totalLessons = course.lessonNodes.count
        }

        // Calculate today's XP
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        todayXP = profile.streaks
            .filter { calendar.startOfDay(for: $0.date) == today }
            .reduce(0) { $0 + $1.xpEarned }
    }
}
