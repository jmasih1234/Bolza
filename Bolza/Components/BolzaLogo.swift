import SwiftUI

/// Bolza lockup — mark + wordmark together.
struct BolzaLogo: View {
    enum Variant {
        case horizontal
        case vertical
    }

    var variant: Variant = .horizontal
    var markSize: CGFloat = 28
    var wordmarkSize: CGFloat = 20
    var markColor: Color = BolzaColor.brand
    var wordmarkColor: Color = BolzaColor.textPrimary

    var body: some View {
        Group {
            switch variant {
            case .horizontal:
                HStack(spacing: BolzaSpacing.xs) {
                    BolzaMark(size: markSize, color: markColor)
                    BolzaWordmark(size: wordmarkSize, color: wordmarkColor)
                }
            case .vertical:
                VStack(spacing: BolzaSpacing.xs) {
                    BolzaMark(size: markSize, color: markColor)
                    BolzaWordmark(size: wordmarkSize, color: wordmarkColor)
                }
            }
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Bolza")
    }
}
