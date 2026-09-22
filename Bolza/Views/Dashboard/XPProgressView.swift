import SwiftUI

struct XPProgressView: View {
    let xp: Int
    let level: Int
    let xpTowardNext: Int

    private var progress: Double {
        Double(xpTowardNext) / Double(AppConstants.xpPerLevel)
    }

    var body: some View {
        GlassCard(tint: .blue) {
            VStack(spacing: 8) {
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundStyle(.yellow)
                    Text("Level \(level)")
                        .font(.headline)
                        .fontWeight(.bold)
                }

                ProgressView(value: progress)
                    .tint(.blue)

                Text("\(xpTowardNext)/\(AppConstants.xpPerLevel) XP")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity)
        }
    }
}
