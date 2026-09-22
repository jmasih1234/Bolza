import Observation
import Foundation

@Observable
final class AppRouter {
    enum Tab: Hashable {
        case home
        case learn
        case explore
        case community
        case profile
    }

    enum Destination: Hashable {
        case lesson(UUID)
        case profile
    }

    var selectedTab: Tab = .home
    var hasCompletedOnboarding = false

    // Per-tab navigation stacks
    var learnPath: [Destination] = []

    func completeOnboarding() {
        hasCompletedOnboarding = true
    }

    func startLesson(_ nodeID: UUID) {
        selectedTab = .learn
        learnPath.append(.lesson(nodeID))
    }

    func finishLesson() {
        if !learnPath.isEmpty {
            learnPath.removeLast()
        }
    }

    func openProfile() {
        selectedTab = .profile
    }
}
