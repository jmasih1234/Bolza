import SwiftUI
import SwiftData

struct RootView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(TutorService.self) private var tutorService
    @State private var router = AppRouter()
    @Query private var profiles: [UserProfile]

    var body: some View {
        Group {
            if profiles.isEmpty || !router.hasCompletedOnboarding {
                OnboardingContainerView(router: router)
            } else {
                NavigationStack(path: $router.navigationPath) {
                    DashboardView(router: router)
                        .navigationDestination(for: AppRouter.Destination.self) { destination in
                            switch destination {
                            case .lesson(let nodeID):
                                LessonContainerView(nodeID: nodeID, router: router)
                            case .profile:
                                ProfileView()
                            }
                        }
                }
            }
        }
        .onAppear {
            if !profiles.isEmpty {
                router.hasCompletedOnboarding = true
            }
        }
    }
}
