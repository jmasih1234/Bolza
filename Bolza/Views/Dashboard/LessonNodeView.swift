import SwiftUI

struct LessonNodeView: View {
    let node: LessonNode

    private var nodeColor: Color {
        if node.isCompleted { return .green }
        if node.isUnlocked { return .accentColor }
        return .gray
    }

    var body: some View {
        VStack(spacing: 6) {
            ZStack {
                Circle()
                    .fill(nodeColor.gradient)
                    .frame(width: 64, height: 64)

                Image(systemName: node.nodeIcon)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
            }
            .shadow(color: node.isUnlocked && !node.isCompleted ? nodeColor.opacity(0.4) : .clear, radius: 8)
            .opacity(node.isUnlocked ? 1.0 : 0.4)

            Text(node.title)
                .font(.caption)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)

            Text(node.subtitle)
                .font(.caption2)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)

            if node.isCompleted && node.bestScore > 0 {
                HStack(spacing: 2) {
                    Image(systemName: "star.fill")
                        .font(.caption2)
                        .foregroundStyle(.yellow)
                    Text("\(node.bestScore)%")
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .padding(.vertical, 4)
    }
}
