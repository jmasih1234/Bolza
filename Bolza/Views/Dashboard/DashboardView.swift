import SwiftUI
import SwiftData

struct DashboardView: View {
    let router: AppRouter
    @Environment(\.modelContext) private var modelContext
    @Query private var profiles: [UserProfile]
    @State private var viewModel = DashboardViewModel()

    private var profile: UserProfile? { profiles.first }
    private var activeCourse: LanguageCourse? { profile?.activeCourse }

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Language header
                if let course = activeCourse {
                    HStack {
                        Text("\(course.language.flag) \(course.language.displayName)")
                            .font(.title2)
                            .fontWeight(.bold)
                        Spacer()
                    }
                    .padding(.horizontal)
                }

                // Stats row
                HStack(spacing: 16) {
                    StreakCardView(streak: viewModel.currentStreak)
                    XPProgressView(
                        xp: viewModel.totalXP,
                        level: viewModel.currentLevel,
                        xpTowardNext: viewModel.xpTowardNextLevel
                    )
                }
                .padding(.horizontal)

                // Skill tree
                if let course = activeCourse {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Your Path")
                            .font(.title3)
                            .fontWeight(.bold)
                            .padding(.horizontal)

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
            }
            .padding(.vertical)
        }
        .navigationTitle("Bolza")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    router.openProfile()
                } label: {
                    Image(systemName: "person.circle")
                        .font(.title3)
                }
            }
        }
        .onAppear {
            if let profile {
                viewModel.load(profile: profile)
            }
        }
    }
}
