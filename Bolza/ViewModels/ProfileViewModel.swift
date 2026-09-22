import Observation
import SwiftData
import Foundation

@Observable
final class ProfileViewModel {
    var totalXP: Int = 0
    var totalLessonsCompleted: Int = 0
    var longestStreak: Int = 0
    var currentStreak: Int = 0
    var languageStats: [(language: TargetLanguage, xp: Int, lessons: Int, level: Int)] = []

    func load(profile: UserProfile) {
        currentStreak = profile.currentStreak

        languageStats = profile.courses.compactMap { course in
            guard let lang = TargetLanguage(rawValue: course.languageRaw) else { return nil }
            return (
                language: lang,
                xp: course.totalXP,
                lessons: course.completedLessonCount,
                level: course.currentLevel
            )
        }

        totalXP = profile.courses.reduce(0) { $0 + $1.totalXP }
        totalLessonsCompleted = profile.courses.reduce(0) { $0 + $1.completedLessonCount }

        // Compute longest streak
        longestStreak = computeLongestStreak(from: profile.streaks)
    }

    private func computeLongestStreak(from streaks: [DailyStreak]) -> Int {
        let calendar = Calendar.current
        let sortedDates = streaks
            .map { calendar.startOfDay(for: $0.date) }
            .sorted()

        guard !sortedDates.isEmpty else { return 0 }

        var longest = 1
        var current = 1

        for i in 1..<sortedDates.count {
            let diff = calendar.dateComponents([.day], from: sortedDates[i-1], to: sortedDates[i]).day ?? 0
            if diff == 1 {
                current += 1
                longest = max(longest, current)
            } else if diff > 1 {
                current = 1
            }
        }
        return longest
    }
}
