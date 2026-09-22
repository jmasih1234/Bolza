import SwiftUI

struct GlassCard<Content: View>: View {
    var tint: Color?
    @ViewBuilder var content: () -> Content

    var body: some View {
        let glass: Glass = if let tint {
            .regular.tint(tint)
        } else {
            .regular
        }
        content()
            .padding()
            .glassEffect(glass, in: .rect(cornerRadius: 20))
    }
}
