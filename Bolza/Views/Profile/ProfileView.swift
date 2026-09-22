import SwiftUI
import SwiftData

struct ProfileView: View {
    @Query private var profiles: [UserProfile]
    @State private var viewModel = ProfileViewModel()

    private var profile: UserProfile? { profiles.first }

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Avatar and name
                VStack(spacing: 12) {
                    Image(systemName: "person.circle.fill")
                        .font(.system(size: 72))
                        .foregroundStyle(.tint)

                    if let profile {
                        Text("Learning \(profile.activeLanguage.displayName)")
                            .font(.headline)
                        Text("Native: \(profile.nativeLanguage.displayName)")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
                .padding(.top)

                // Stats grid
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                    StatCard(title: "Total XP", value: "\(viewModel.totalXP)", icon: "star.fill", color: .yellow)
                    StatCard(title: "Lessons", value: "\(viewModel.totalLessonsCompleted)", icon: "book.fill", color: .blue)
                    StatCard(title: "Current Streak", value: "\(viewModel.currentStreak) days", icon: "flame.fill", color: .orange)
                    StatCard(title: "Best Streak", value: "\(viewModel.longestStreak) days", icon: "trophy.fill", color: .purple)
                }
                .padding(.horizontal)

                // Language breakdown
                if !viewModel.languageStats.isEmpty {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Languages")
                            .font(.title3)
                            .fontWeight(.bold)
                            .padding(.horizontal)

                        ForEach(viewModel.languageStats, id: \.language) { stat in
                            HStack {
                                Text(stat.language.flag)
                                    .font(.title2)
                                VStack(alignment: .leading) {
                                    Text(stat.language.displayName)
                                        .font(.headline)
                                    Text("Level \(stat.level) \u{00B7} \(stat.xp) XP \u{00B7} \(stat.lessons) lessons")
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                                Spacer()
                            }
                            .padding()
                            .glassEffect(in: .rect(cornerRadius: 16))
                            .padding(.horizontal)
                        }
                    }
                }
            }
        }
        .navigationTitle("Profile")
        .onAppear {
            if let profile {
                viewModel.load(profile: profile)
            }
        }
    }
}

private struct StatCard: View {
    let title: String
    let value: String
    let icon: String
    let color: Color

    var body: some View {
        GlassCard(tint: color.opacity(0.5)) {
            VStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundStyle(color)
                Text(value)
                    .font(.headline)
                    .fontWeight(.bold)
                Text(title)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity)
        }
    }
}
