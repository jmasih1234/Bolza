import SwiftUI

/// Minimal teal progress bar.
struct BolzaProgressBar: View {
    /// 0.0 to 1.0
    let progress: Double
    var height: CGFloat = 4
    var trackColor: Color = BolzaColor.surfaceElevated
    var fillColor: Color = BolzaColor.brand

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: height / 2)
                    .fill(trackColor)

                RoundedRectangle(cornerRadius: height / 2)
                    .fill(fillColor)
                    .frame(width: geo.size.width * min(max(progress, 0), 1))
            }
        }
        .frame(height: height)
        .accessibilityValue("\(Int(progress * 100)) percent")
    }
}
