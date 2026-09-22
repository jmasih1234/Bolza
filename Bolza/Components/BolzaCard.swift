import SwiftUI

/// Bolza surface card — Graphite background with subtle border.
/// Cards represent actual objects (lessons, progress, content), not arbitrary sections.
struct BolzaCard<Content: View>: View {
    var elevated: Bool = false
    @ViewBuilder var content: () -> Content

    var body: some View {
        content()
            .padding(BolzaSpacing.md)
            .background(
                RoundedRectangle(cornerRadius: BolzaRadius.card)
                    .fill(elevated ? BolzaColor.surfaceElevated : BolzaColor.surface)
            )
            .overlay(
                RoundedRectangle(cornerRadius: BolzaRadius.card)
                    .stroke(BolzaColor.border, lineWidth: 1)
            )
    }
}
