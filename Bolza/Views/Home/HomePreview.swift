import SwiftUI
import SwiftData

// MARK: - Full Home with Backdrop + Tab Bar

#Preview("Full Home Screen") {
    VStack(spacing: 0) {
        BolzaBackground(learningLanguage: .spanish) {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {
                    // Header
                    VStack(alignment: .leading, spacing: BolzaSpacing.lg) {
                        HStack {
                            BolzaMark(size: 28, color: BolzaColor.brand)
                            Spacer()
                        }

                        VStack(alignment: .leading, spacing: BolzaSpacing.xxs) {
                            Text("Good morning,")
                                .font(BolzaTypography.displayLarge)
                                .foregroundStyle(BolzaColor.textPrimary)
                            Text("Learner.")
                                .font(BolzaTypography.displayLarge)
                                .foregroundStyle(BolzaColor.warmAccent)
                        }

                        Text("Today a new word,\ntomorrow a new world.")
                            .font(BolzaTypography.editorialBody)
                            .foregroundStyle(BolzaColor.textTertiary)
                    }
                    .padding(.horizontal, BolzaSpacing.lg)
                    .padding(.bottom, BolzaSpacing.xxl)

                    // Continue Learning
                    BolzaCard {
                        VStack(alignment: .leading, spacing: BolzaSpacing.md) {
                            BolzaSectionHeader(title: "Continue Learning")
                            BolzaLanguageBadge(language: .spanish)

                            VStack(alignment: .leading, spacing: BolzaSpacing.xxs) {
                                Text("Verb Basics")
                                    .font(BolzaTypography.titleMedium)
                                    .foregroundStyle(BolzaColor.textPrimary)
                                Text("-ar verbs in present")
                                    .font(BolzaTypography.caption)
                                    .foregroundStyle(BolzaColor.textSecondary)
                            }

                            VStack(alignment: .leading, spacing: BolzaSpacing.xs) {
                                BolzaProgressBar(progress: 0.6)
                                Text("60%")
                                    .font(BolzaTypography.micro)
                                    .foregroundStyle(BolzaColor.brand)
                            }

                            HStack {
                                Spacer()
                                BolzaButton(title: "Resume", icon: "arrow.right") {}
                            }
                        }
                    }
                    .padding(.horizontal, BolzaSpacing.lg)
                    .padding(.bottom, BolzaSpacing.section)

                    // Progress
                    VStack(alignment: .leading, spacing: BolzaSpacing.md) {
                        BolzaSectionHeader(title: "Your Progress")
                            .padding(.horizontal, BolzaSpacing.xxs)

                        HStack(spacing: BolzaSpacing.sm) {
                            BolzaCard {
                                VStack(spacing: BolzaSpacing.xs) {
                                    Text("7")
                                        .font(BolzaTypography.displaySmall)
                                        .foregroundStyle(BolzaColor.warmAccent)
                                    Text("Day Streak")
                                        .font(BolzaTypography.micro)
                                        .foregroundStyle(BolzaColor.textTertiary)
                                }
                                .frame(maxWidth: .infinity)
                            }

                            BolzaCard {
                                VStack(spacing: BolzaSpacing.xs) {
                                    Text("45")
                                        .font(BolzaTypography.displaySmall)
                                        .foregroundStyle(BolzaColor.brand)
                                    Text("XP Today")
                                        .font(BolzaTypography.micro)
                                        .foregroundStyle(BolzaColor.textTertiary)
                                }
                                .frame(maxWidth: .infinity)
                            }

                            BolzaCard {
                                VStack(spacing: BolzaSpacing.xs) {
                                    Text("Lv 2")
                                        .font(BolzaTypography.displaySmall)
                                        .foregroundStyle(BolzaColor.seafoam)
                                    Text("45/100")
                                        .font(BolzaTypography.micro)
                                        .foregroundStyle(BolzaColor.textTertiary)
                                }
                                .frame(maxWidth: .infinity)
                            }
                        }
                    }
                    .padding(.horizontal, BolzaSpacing.lg)
                    .padding(.bottom, BolzaSpacing.section)

                    // Quick Actions
                    VStack(alignment: .leading, spacing: BolzaSpacing.md) {
                        BolzaSectionHeader(title: "Quick Actions")
                            .padding(.horizontal, BolzaSpacing.xxs)

                        let actionData: [(icon: String, label: String)] = [
                            ("book", "Practice"),
                            ("rectangle.on.rectangle", "Flashcards"),
                            ("mic", "Speak"),
                            ("safari", "Explore"),
                        ]

                        LazyVGrid(
                            columns: [
                                GridItem(.flexible(), spacing: BolzaSpacing.sm),
                                GridItem(.flexible(), spacing: BolzaSpacing.sm),
                            ],
                            spacing: BolzaSpacing.sm
                        ) {
                            ForEach(actionData, id: \.label) { action in
                                HStack(spacing: BolzaSpacing.sm) {
                                    Image(systemName: action.icon)
                                        .font(.system(size: 16))
                                        .foregroundStyle(BolzaColor.brand)
                                    Text(action.label)
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
                        }
                    }
                    .padding(.horizontal, BolzaSpacing.lg)
                    .padding(.bottom, BolzaSpacing.section)

                    // Today's Goal
                    VStack(alignment: .leading, spacing: BolzaSpacing.md) {
                        BolzaSectionHeader(title: "Today's Goal")
                            .padding(.horizontal, BolzaSpacing.xxs)

                        HStack(spacing: BolzaSpacing.md) {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.system(size: 20))
                                .foregroundStyle(BolzaColor.success)

                            VStack(alignment: .leading, spacing: 2) {
                                Text("Complete 1 lesson")
                                    .font(BolzaTypography.body)
                                    .foregroundStyle(BolzaColor.textSecondary)
                                    .strikethrough(true, color: BolzaColor.textTertiary)
                                Text("Done for today")
                                    .font(BolzaTypography.micro)
                                    .foregroundStyle(BolzaColor.success)
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
                                .stroke(BolzaColor.success.opacity(0.3), lineWidth: 1)
                        )
                    }
                    .padding(.horizontal, BolzaSpacing.lg)
                    .padding(.bottom, BolzaSpacing.xxxl)
                }
                .padding(.top, BolzaSpacing.md)
            }
        }
        .frame(maxHeight: .infinity)

        // Tab bar
        BolzaTabBarPreview()
    }
    .preferredColorScheme(.dark)
}

private struct BolzaTabBarPreview: View {
    @State private var selected: AppRouter.Tab = .home

    var body: some View {
        BolzaTabBar(selectedTab: $selected)
    }
}

// MARK: - Design System Reference

#Preview("Design System") {
    ScrollView {
        VStack(alignment: .leading, spacing: 32) {
            BolzaLogo(variant: .horizontal)
            BolzaMark(size: 48, color: BolzaColor.brand)

            HStack(spacing: 8) {
                Circle().fill(BolzaColor.background).frame(width: 32, height: 32)
                    .overlay(Circle().stroke(BolzaColor.border))
                Circle().fill(BolzaColor.surface).frame(width: 32, height: 32)
                Circle().fill(BolzaColor.surfaceElevated).frame(width: 32, height: 32)
                Circle().fill(BolzaColor.brand).frame(width: 32, height: 32)
                Circle().fill(BolzaColor.seafoam).frame(width: 32, height: 32)
                Circle().fill(BolzaColor.warmAccent).frame(width: 32, height: 32)
                Circle().fill(BolzaColor.warmLight).frame(width: 32, height: 32)
                Circle().fill(BolzaColor.textPrimary).frame(width: 32, height: 32)
            }

            VStack(alignment: .leading, spacing: 8) {
                Text("Display Large").font(BolzaTypography.displayLarge)
                Text("Display Medium").font(BolzaTypography.displayMedium)
                Text("Editorial Body").font(BolzaTypography.editorialBody)
                Text("Heading").font(BolzaTypography.heading)
                Text("Body").font(BolzaTypography.body)
                Text("Caption").font(BolzaTypography.caption)
                Text("MICRO").font(BolzaTypography.micro)
            }
            .foregroundStyle(BolzaColor.textPrimary)

            BolzaButton(title: "Resume", icon: "arrow.right") {}
            BolzaButton(title: "Secondary", style: .secondary) {}
            BolzaProgressBar(progress: 0.6)
            BolzaLanguageBadge(language: .spanish)
        }
        .padding(20)
    }
    .background(BolzaColor.background)
    .preferredColorScheme(.dark)
}
