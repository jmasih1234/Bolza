import SwiftUI

/// Bolza geometric B mark.
///
/// A constructed abstract B formed by two curved geometric forms
/// with negative space suggesting openness, connection, and exchange.
///
/// This is a DEVELOPMENT mark built as a SwiftUI Shape.
/// TODO: Replace with the final production SVG/PDF vector asset
/// when available. The final asset should be placed in Assets.xcassets
/// as "BolzaMark" and this shape used only as a fallback.
struct BolzaMarkShape: Shape {
    func path(in rect: CGRect) -> Path {
        let w = rect.width
        let h = rect.height

        var path = Path()

        // The B is constructed from two open curved forms
        // separated by a vertical negative-space gap.

        // Vertical spine — left edge
        let spineX = w * 0.18

        // Upper bowl
        path.move(to: CGPoint(x: spineX, y: h * 0.06))
        path.addLine(to: CGPoint(x: spineX, y: h * 0.48))
        path.addLine(to: CGPoint(x: w * 0.42, y: h * 0.48))
        path.addCurve(
            to: CGPoint(x: w * 0.42, y: h * 0.06),
            control1: CGPoint(x: w * 0.78, y: h * 0.46),
            control2: CGPoint(x: w * 0.78, y: h * 0.08)
        )
        path.closeSubpath()

        // Lower bowl — wider
        path.move(to: CGPoint(x: spineX, y: h * 0.52))
        path.addLine(to: CGPoint(x: spineX, y: h * 0.94))
        path.addLine(to: CGPoint(x: w * 0.48, y: h * 0.94))
        path.addCurve(
            to: CGPoint(x: w * 0.48, y: h * 0.52),
            control1: CGPoint(x: w * 0.88, y: h * 0.92),
            control2: CGPoint(x: w * 0.88, y: h * 0.54)
        )
        path.closeSubpath()

        return path
    }
}

/// Displays the Bolza geometric B mark.
struct BolzaMark: View {
    var size: CGFloat = 32
    var color: Color = BolzaColor.brand

    var body: some View {
        BolzaMarkShape()
            .fill(color)
            .frame(width: size, height: size)
            .accessibilityLabel("Bolza")
            .accessibilityHidden(true)
    }
}
