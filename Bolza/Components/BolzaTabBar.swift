import SwiftUI

/// Custom Bolza tab bar — near-black, compact, restrained icons.
/// Selected: teal. Inactive: muted off-white.
struct BolzaTabBar: View {
    @Binding var selectedTab: AppRouter.Tab

    private let tabs: [(tab: AppRouter.Tab, icon: String, label: String)] = [
        (.home, "house", "Home"),
        (.learn, "book", "Learn"),
        (.explore, "safari", "Explore"),
        (.community, "bubble.left.and.bubble.right", "Community"),
        (.profile, "person", "Profile"),
    ]

    var body: some View {
        HStack(spacing: 0) {
            ForEach(tabs, id: \.tab) { item in
                Button {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        selectedTab = item.tab
                    }
                } label: {
                    VStack(spacing: 3) {
                        Image(systemName: item.icon)
                            .font(.system(size: 18, weight: .regular))
                            .symbolVariant(selectedTab == item.tab ? .fill : .none)

                        Text(item.label)
                            .font(.system(size: 10, weight: .medium))
                    }
                    .foregroundStyle(
                        selectedTab == item.tab
                            ? BolzaColor.brand
                            : BolzaColor.textTertiary
                    )
                    .frame(maxWidth: .infinity)
                    .padding(.top, BolzaSpacing.xs)
                    .padding(.bottom, BolzaSpacing.xxs)
                }
                .buttonStyle(.plain)
                .accessibilityLabel(item.label)
            }
        }
        .padding(.horizontal, BolzaSpacing.xs)
        .background(
            VStack(spacing: 0) {
                BolzaColor.border
                    .frame(height: 0.5)
                BolzaColor.background
            }
            .ignoresSafeArea(edges: .bottom)
        )
    }
}
