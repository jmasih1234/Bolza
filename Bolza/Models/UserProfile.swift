import SwiftData
import Foundation

@Model
final class UserProfile {
    var id: UUID = UUID()
    var createdAt: Date = Date()
    var nativeLanguageRaw: String = NativeLanguage.english.rawValue
    var activeLanguageRaw: String = TargetLanguage.spanish.rawValue

    @Relationship(deleteRule: .cascade, inverse: \LanguageCourse.userProfile)
    var courses: [LanguageCourse] = []

    @Relationship(deleteRule: .cascade, inverse: \DailyStreak.userProfile)
    var streaks: [DailyStreak] = []

    @Transient
    var nativeLanguage: NativeLanguage {
        get { NativeLanguage(rawValue: nativeLanguageRaw) ?? .english }
        set { nativeLanguageRaw = newValue.rawValue }
    }

    @Transient
    var activeLanguage: TargetLanguage {
        get { TargetLanguage(rawValue: activeLanguageRaw) ?? .spanish }
        set { activeLanguageRaw = newValue.rawValue }
    }

    @Transient
    var activeCourse: LanguageCourse? {
        courses.first { $0.languageRaw == activeLanguageRaw }
    }

    @Transient
    var currentStreak: Int {
        let calendar = Calendar.current
        let sortedStreaks = streaks
            .sorted { $0.date > $1.date }

        var count = 0
        var expectedDate = calendar.startOfDay(for: Date())

        for streak in sortedStreaks {
            let streakDay = calendar.startOfDay(for: streak.date)
            if streakDay == expectedDate {
                count += 1
                expectedDate = calendar.date(byAdding: .day, value: -1, to: expectedDate)!
            } else {
                break
            }
        }
        return count
    }

    init(nativeLanguage: NativeLanguage, activeLanguage: TargetLanguage) {
        self.nativeLanguageRaw = nativeLanguage.rawValue
        self.activeLanguageRaw = activeLanguage.rawValue
    }
}
