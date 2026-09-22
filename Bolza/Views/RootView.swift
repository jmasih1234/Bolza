import SwiftUI
import SwiftData

struct RootView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(TutorService.self) private var tutorService
    @State private var router = AppRouter()
    @Query private var profiles: [UserProfile]

    private var profile: UserProfile? { profiles.first }
    private var activeCourse: LanguageCourse? { profile?.activeCourse }

    var body: some View {
        Group {
            if profiles.isEmpty || !router.hasCompletedOnboarding {
                OnboardingContainerView(router: router)
            } else {
                mainApp
            }
        }
        .onAppear {
            if !profiles.isEmpty {
                router.hasCompletedOnboarding = true
            }
        }
    }

    // MARK: - Main App Shell

    private var mainApp: some View {
        VStack(spacing: 0) {
            // Active tab content
            Group {
                switch router.selectedTab {
                case .home:
                    HomeView(router: router)

                case .learn:
                    NavigationStack(path: $router.learnPath) {
                        LearnTabView(router: router)
                            .navigationDestination(for: AppRouter.Destination.self) { dest in
                                switch dest {
                                case .lesson(let nodeID):
                                    LessonContainerView(nodeID: nodeID, router: router)
                                case .profile:
                                    ProfileView()
                                }
                            }
                    }

                case .explore:
                    PlaceholderTabView(
                        title: "Explore",
                        subtitle: "Cultural discovery coming soon",
                        icon: "safari"
                    )

                case .community:
                    PlaceholderTabView(
                        title: "Community",
                        subtitle: "Connect with learners soon",
                        icon: "bubble.left.and.bubble.right"
                    )

                case .profile:
                    NavigationStack {
                        ProfileView()
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            // Tab bar
            BolzaTabBar(selectedTab: $router.selectedTab)
        }
        .background(BolzaColor.background.ignoresSafeArea())
    }
}

// MARK: - Learn Tab (houses the existing skill tree + lesson flow)

struct LearnTabView: View {
    let router: AppRouter
    @Query private var profiles: [UserProfile]
    @State private var viewModel = DashboardViewModel()

    private var profile: UserProfile? { profiles.first }
    private var activeCourse: LanguageCourse? { profile?.activeCourse }

    var body: some View {
        BolzaBackground(learningLanguage: profile?.activeLanguage, showMultilingual: false) {
            ScrollView {
                VStack(spacing: BolzaSpacing.xl) {
                    // Language header
                    if let course = activeCourse {
                        HStack {
                            BolzaLanguageBadge(language: course.language)
                            Spacer()
                            Text("Unit \(viewModel.completedLessons + 1)")
                                .font(BolzaTypography.caption)
                                .foregroundStyle(BolzaColor.textTertiary)
                        }
                        .padding(.horizontal, BolzaSpacing.lg)
                    }

                    // Skill tree
                    if let course = activeCourse {
                        SkillTreeView(
                            nodes: course.sortedNodes,
                            onSelectNode: { node in
                                if node.isUnlocked {
                                    router.startLesson(node.id)
                                }
                            }
                        )
                    }
                }
                .padding(.vertical, BolzaSpacing.lg)
            }
        }
        .navigationTitle("Learn")
        .toolbarColorScheme(.dark, for: .navigationBar)
        .onAppear {
            if let profile { viewModel.load(profile: profile) }
        }
    }
}

// MARK: - Placeholder for future tabs

struct PlaceholderTabView: View {
    let title: String
    let subtitle: String
    let icon: String

    var body: some View {
        BolzaBackground(showMultilingual: true) {
            VStack(spacing: BolzaSpacing.md) {
                Image(systemName: icon)
                    .font(.system(size: 40, weight: .light))
                    .foregroundStyle(BolzaColor.textTertiary)

                Text(title)
                    .font(BolzaTypography.displaySmall)
                    .foregroundStyle(BolzaColor.textPrimary)

                Text(subtitle)
                    .font(BolzaTypography.body)
                    .foregroundStyle(BolzaColor.textSecondary)
            }
        }
    }
}
