import SwiftUI
import SwiftData

struct HomeView: View {
    let router: AppRouter
    @Query private var profiles: [UserProfile]
    @State private var viewModel = DashboardViewModel()

    private var profile: UserProfile? { profiles.first }
    private var activeCourse: LanguageCourse? { profile?.activeCourse }

    var body: some View {
        BolzaBackground(learningLanguage: profile?.activeLanguage) {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {
                    HomeHeaderSection(profile: profile)
                        .padding(.bottom, BolzaSpacing.xxl)

                    if let course = activeCourse {
                        ContinueLearningSection(
                            course: course,
                            completedLessons: viewModel.completedLessons,
                            totalLessons: viewModel.totalLessons,
                            onResume: {
                                if let next = course.nextLesson {
                                    router.startLesson(next.id)
                                }
                            }
                        )
                        .padding(.horizontal, BolzaSpacing.lg)
                        .padding(.bottom, BolzaSpacing.section)
                    }

                    DailyProgressSection(
                        streak: viewModel.currentStreak,
                        todayXP: viewModel.todayXP,
                        level: viewModel.currentLevel,
                        xpTowardNext: viewModel.xpTowardNextLevel
                    )
                    .padding(.horizontal, BolzaSpacing.lg)
                    .padding(.bottom, BolzaSpacing.section)

                    QuickActionsSection(router: router)
                        .padding(.horizontal, BolzaSpacing.lg)
                        .padding(.bottom, BolzaSpacing.section)

                    TodaysGoalSection(
                        completedLessons: viewModel.completedLessons
                    )
                    .padding(.horizontal, BolzaSpacing.lg)
                    .padding(.bottom, BolzaSpacing.xxxl)
                }
                .padding(.top, BolzaSpacing.md)
            }
        }
        .onAppear {
            if let profile { viewModel.load(profile: profile) }
        }
    }
}

// MARK: - Header

private struct HomeHeaderSection: View {
    let profile: UserProfile?

    private var greeting: String {
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
        case 5..<12: return "Good morning,"
        case 12..<17: return "Good afternoon,"
        case 17..<22: return "Good evening,"
        default: return "Good evening,"
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: BolzaSpacing.lg) {
            // Mark
            HStack {
                BolzaMark(size: 28, color: BolzaColor.brand)
                Spacer()
            }
            .padding(.horizontal, BolzaSpacing.lg)

            // Greeting
            VStack(alignment: .leading, spacing: BolzaSpacing.xxs) {
                Text(greeting)
                    .font(BolzaTypography.displayLarge)
                    .foregroundStyle(BolzaColor.textPrimary)

                if profile != nil {
                    Text("Learner.")
                        .font(BolzaTypography.displayLarge)
                        .foregroundStyle(BolzaColor.warmAccent)
                }
            }
            .padding(.horizontal, BolzaSpacing.lg)

            // Editorial statement
            Text("Today a new word,\ntomorrow a new world.")
                .font(BolzaTypography.editorialBody)
                .foregroundStyle(BolzaColor.textTertiary)
                .padding(.horizontal, BolzaSpacing.lg)
        }
    }
}

// MARK: - Continue Learning

private struct ContinueLearningSection: View {
    let course: LanguageCourse
    let completedLessons: Int
    let totalLessons: Int
    let onResume: () -> Void

    private var progress: Double {
        guard totalLessons > 0 else { return 0 }
        return Double(completedLessons) / Double(totalLessons)
    }

    var body: some View {
        BolzaCard {
            VStack(alignment: .leading, spacing: BolzaSpacing.md) {
                BolzaSectionHeader(title: "Continue Learning")

                BolzaLanguageBadge(language: course.language)

                if let next = course.nextLesson {
                    VStack(alignment: .leading, spacing: BolzaSpacing.xxs) {
                        Text(next.title)
                            .font(BolzaTypography.titleMedium)
                            .foregroundStyle(BolzaColor.textPrimary)
                        Text(next.subtitle)
                            .font(BolzaTypography.caption)
                            .foregroundStyle(BolzaColor.textSecondary)
                    }
                }

                VStack(alignment: .leading, spacing: BolzaSpacing.xs) {
                    BolzaProgressBar(progress: progress)
                    Text("\(Int(progress * 100))%")
                        .font(BolzaTypography.micro)
                        .foregroundStyle(BolzaColor.brand)
                }

                HStack {
                    Spacer()
                    BolzaButton(title: "Resume", icon: "arrow.right", action: onResume)
                }
            }
        }
    }
}

// MARK: - Daily Progress

private struct DailyProgressSection: View {
    let streak: Int
    let todayXP: Int
    let level: Int
    let xpTowardNext: Int

    var body: some View {
        VStack(alignment: .leading, spacing: BolzaSpacing.md) {
            BolzaSectionHeader(title: "Your Progress")
                .padding(.horizontal, BolzaSpacing.xxs)

            HStack(spacing: BolzaSpacing.sm) {
                ProgressStat(
                    value: "\(streak)",
                    label: "Day Streak",
                    accent: streak > 0 ? BolzaColor.warmAccent : BolzaColor.textTertiary
                )

                ProgressStat(
                    value: "\(todayXP)",
                    label: "XP Today",
                    accent: BolzaColor.brand
                )

                ProgressStat(
                    value: "Lv \(level)",
                    label: "\(xpTowardNext)/\(AppConstants.xpPerLevel)",
                    accent: BolzaColor.seafoam
                )
            }
        }
    }
}

private struct ProgressStat: View {
    let value: String
    let label: String
    var accent: Color = BolzaColor.textPrimary

    var body: some View {
        BolzaCard {
            VStack(spacing: BolzaSpacing.xs) {
                Text(value)
                    .font(BolzaTypography.displaySmall)
                    .foregroundStyle(accent)

                Text(label)
                    .font(BolzaTypography.micro)
                    .foregroundStyle(BolzaColor.textTertiary)
                    .multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity)
        }
    }
}

// MARK: - Quick Actions

private struct QuickActionsSection: View {
    let router: AppRouter

    private let actions: [(icon: String, label: String, tab: AppRouter.Tab?)] = [
        ("book", "Practice", .learn),
        ("rectangle.on.rectangle", "Flashcards", nil),
        ("mic", "Speak", nil),
        ("safari", "Explore", .explore),
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: BolzaSpacing.md) {
            BolzaSectionHeader(title: "Quick Actions")
                .padding(.horizontal, BolzaSpacing.xxs)

            LazyVGrid(
                columns: [
                    GridItem(.flexible(), spacing: BolzaSpacing.sm),
                    GridItem(.flexible(), spacing: BolzaSpacing.sm),
                ],
                spacing: BolzaSpacing.sm
            ) {
                ForEach(actions, id: \.label) { action in
                    QuickActionTile(icon: action.icon, label: action.label) {
                        if let tab = action.tab {
                            router.selectedTab = tab
                        }
                    }
                }
            }
        }
    }
}

private struct QuickActionTile: View {
    let icon: String
    let label: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: BolzaSpacing.sm) {
                Image(systemName: icon)
                    .font(.system(size: 16, weight: .regular))
                    .foregroundStyle(BolzaColor.brand)

                Text(label)
                    .font(BolzaTypography.caption)
                    .foregroundStyle(BolzaColor.textPrimary)

                Spacer()
            }
            .padding(BolzaSpacing.md)
            .background(
                RoundedRectangle(cornerRadius: BolzaRadius.card)
                    .fill(BolzaColor.surface)
            )
            .overlay(
                RoundedRectangle(cornerRadius: BolzaRadius.card)
                    .stroke(BolzaColor.border, lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Today's Goal

private struct TodaysGoalSection: View {
    let completedLessons: Int

    private var goalMet: Bool { completedLessons > 0 }

    var body: some View {
        VStack(alignment: .leading, spacing: BolzaSpacing.md) {
            BolzaSectionHeader(title: "Today's Goal")
                .padding(.horizontal, BolzaSpacing.xxs)

            HStack(spacing: BolzaSpacing.md) {
                Image(systemName: goalMet ? "checkmark.circle.fill" : "circle")
                    .font(.system(size: 20))
                    .foregroundStyle(goalMet ? BolzaColor.success : BolzaColor.textTertiary)

                VStack(alignment: .leading, spacing: 2) {
                    Text("Complete 1 lesson")
                        .font(BolzaTypography.body)
                        .foregroundStyle(
                            goalMet ? BolzaColor.textSecondary : BolzaColor.textPrimary
                        )
                        .strikethrough(goalMet, color: BolzaColor.textTertiary)

                    if goalMet {
                        Text("Done for today")
                            .font(BolzaTypography.micro)
                            .foregroundStyle(BolzaColor.success)
                    }
                }

                Spacer()
            }
            .padding(BolzaSpacing.md)
            .background(
                RoundedRectangle(cornerRadius: BolzaRadius.card)
                    .fill(BolzaColor.surface)
            )
            .overlay(
                RoundedRectangle(cornerRadius: BolzaRadius.card)
                    .stroke(
                        goalMet ? BolzaColor.success.opacity(0.3) : BolzaColor.border,
                        lineWidth: 1
                    )
            )
        }
    }
}
