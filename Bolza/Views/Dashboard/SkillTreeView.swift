import SwiftUI

struct SkillTreeView: View {
    let nodes: [LessonNode]
    let onSelectNode: (LessonNode) -> Void

    var body: some View {
        LazyVStack(spacing: 0) {
            ForEach(Array(nodes.enumerated()), id: \.element.id) { index, node in
                VStack(spacing: 0) {
                    // Connector line from previous node
                    if index > 0 {
                        Rectangle()
                            .fill(node.isUnlocked ? Color.accentColor.opacity(0.5) : Color.secondary.opacity(0.2))
                            .frame(width: 3, height: 32)
                    }

                    LessonNodeView(node: node)
                        .onTapGesture { onSelectNode(node) }
                        .offset(x: index.isMultiple(of: 2) ? -30 : 30)
                }
            }
        }
        .padding(.horizontal, 40)
    }
}
