import SwiftUI

struct StreakFlame: View {
    let streakCount: Int
    @State private var isPulsing = false

    private var isActive: Bool { streakCount > 0 }

    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: isActive ? "flame.fill" : "flame")
                .font(.title2)
                .foregroundStyle(isActive ? .orange : .secondary)
                .scaleEffect(isPulsing ? 1.15 : 1.0)
                .animation(
                    isActive
                        ? .easeInOut(duration: 1).repeatForever(autoreverses: true)
                        : .default,
                    value: isPulsing
                )

            Text("\(streakCount)")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundStyle(isActive ? .primary : .secondary)
        }
        .onAppear {
            if isActive { isPulsing = true }
        }
    }
}
