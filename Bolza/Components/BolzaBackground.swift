import SwiftUI

/// Bolza layered background system.
///
/// Layer 1: Midnight background
/// Layer 2: Subtle tonal variation (radial gradient)
/// Layer 3: Multilingual typography
/// Layer 4: Content (provided by caller)
struct BolzaBackground<Content: View>: View {
    var learningLanguage: TargetLanguage?
    var showMultilingual: Bool = true
    @ViewBuilder var content: () -> Content

    var body: some View {
        ZStack {
            // Layer 1: Midnight
            BolzaColor.background
                .ignoresSafeArea()

            // Layer 2: Subtle tonal variation
            RadialGradient(
                colors: [
                    BolzaColor.surface.opacity(0.3),
                    BolzaColor.background.opacity(0)
                ],
                center: .topLeading,
                startRadius: 0,
                endRadius: 600
            )
            .ignoresSafeArea()

            // Layer 3: Multilingual fragments
            if showMultilingual {
                MultilingualBackdrop(
                    learningLanguage: learningLanguage,
                    seed: learningLanguage.hashValue
                )
                .ignoresSafeArea()
            }

            // Layer 4: Content
            content()
        }
    }
}
