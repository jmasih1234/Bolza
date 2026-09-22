import SwiftUI
import SwiftData

@main
struct BolzaApp: App {
    @State private var tutorService = TutorService()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(tutorService)
                .preferredColorScheme(.dark)
        }
        .modelContainer(for: [
            UserProfile.self,
            LanguageCourse.self,
            LessonNode.self,
            LessonProgress.self,
            DailyStreak.self
        ])
    }
}
