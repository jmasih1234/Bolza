import SwiftUI

struct StreakCardView: View {
    let streak: Int

    var body: some View {
        GlassCard(tint: streak > 0 ? .orange : nil) {
            VStack(spacing: 8) {
                StreakFlame(streakCount: streak)
                Text(streak == 1 ? "1 day" : "\(streak) days")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity)
        }
    }
}
