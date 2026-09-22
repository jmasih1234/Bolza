import SwiftUI

/// Bolza wordmark using the editorial serif.
///
/// TODO: Replace with a final custom-lettered wordmark asset (SVG/PDF)
/// when available. Place in Assets.xcassets as "BolzaWordmark".
struct BolzaWordmark: View {
    var size: CGFloat = 22
    var color: Color = BolzaColor.textPrimary

    var body: some View {
        Text("Bolza")
            .font(BolzaTypography.serif(size: size, weight: .semibold))
            .foregroundStyle(color)
            .tracking(1.5)
            .accessibilityLabel("Bolza")
    }
}
