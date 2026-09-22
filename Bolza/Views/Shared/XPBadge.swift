import SwiftUI

struct XPBadge: View {
    let amount: Int
    @State private var isAnimating = false

    var body: some View {
        Text("+\(amount) XP")
            .font(.headline)
            .fontWeight(.bold)
            .foregroundStyle(.orange)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .glassEffect(.regular.tint(.orange), in: .capsule)
            .scaleEffect(isAnimating ? 1.2 : 0.8)
            .opacity(isAnimating ? 1 : 0)
            .onAppear {
                withAnimation(.spring(duration: 0.5, bounce: 0.4)) {
                    isAnimating = true
                }
            }
    }
}
