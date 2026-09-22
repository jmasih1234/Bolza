import SwiftUI

struct GlassCard<Content: View>: View {
    var tint: Color?
    @ViewBuilder var content: () -> Content

    var body: some View {
        content()
            .padding()
            .glassEffect(
                tint != nil ? .regular.tint(tint!) : .regular,
                in: .rect(cornerRadius: 20)
            )
    }
}
