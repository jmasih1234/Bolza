import Observation
import Foundation

@Observable
final class AppRouter {
    enum Destination: Hashable {
        case lesson(UUID)
        case profile
    }

    var navigationPath: [Destination] = []
    var hasCompletedOnboarding = false

    func completeOnboarding() {
        hasCompletedOnboarding = true
    }

    func startLesson(_ nodeID: UUID) {
        navigationPath.append(.lesson(nodeID))
    }

    func finishLesson() {
        if !navigationPath.isEmpty {
            navigationPath.removeLast()
        }
    }

    func openProfile() {
        navigationPath.append(.profile)
    }
}
