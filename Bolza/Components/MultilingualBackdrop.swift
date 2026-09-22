import SwiftUI

/// Words and short phrases from different languages positioned subtly
/// throughout the background. This is Bolza's primary visual signature.
///
/// Rules:
/// - Very low opacity (0.03–0.08)
/// - 3–8 visible fragments per viewport
/// - Different sizes, scripts, partial clipping at edges
/// - Fully decorative — VoiceOver ignores it
/// - NOT a word cloud, NOT a wallpaper, NOT visual noise
struct MultilingualBackdrop: View {
    /// The user's current learning language, used to bias word selection.
    /// If nil, uses a global multilingual set.
    var learningLanguage: TargetLanguage?

    /// Seed for deterministic randomization so the layout is stable per session.
    var seed: Int = 0

    var body: some View {
        GeometryReader { geo in
            let fragments = Self.fragments(
                for: learningLanguage,
                seed: seed,
                count: 7
            )

            ZStack {
                ForEach(Array(fragments.enumerated()), id: \.offset) { index, fragment in
                    let placement = Self.placement(
                        index: index,
                        total: fragments.count,
                        size: geo.size,
                        seed: seed
                    )

                    Text(fragment.word)
                        .font(Self.font(for: fragment.scale))
                        .foregroundStyle(Self.fragmentColor(for: fragment))
                        .opacity(fragment.opacity)
                        .rotationEffect(.degrees(placement.rotation))
                        .position(x: placement.x, y: placement.y)
                }
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .accessibilityHidden(true)
        .allowsHitTesting(false)
    }

    // MARK: - Data

    struct Fragment {
        let word: String
        let scale: FragmentScale
        let opacity: Double
        let isWarm: Bool // Use sand color instead of white
    }

    enum FragmentScale {
        case small, medium, large
    }

    struct Placement {
        let x: CGFloat
        let y: CGFloat
        let rotation: Double
    }

    // MARK: - Word Collections

    private static let globalWords: [String] = [
        "Hola", "Bonjour", "Ciao", "Olá", "Hallo",
        "你好", "こんにちは", "안녕하세요", "Salut",
        "Gracias", "Merci", "Danke", "Amore", "Liebe",
        "世界", "Viaje", "Voyage", "Reise",
        "Amigo", "Ami", "Freund", "朋友",
        "Cultura", "Lingua", "Sprache", "Parola",
        "Luz", "Lumière", "Licht", "光",
        "Vida", "Vie", "Leben", "生活",
    ]

    private static let spanishWords: [String] = [
        "Hola", "Gracias", "Amigo", "Viaje", "Comida",
        "Familia", "Mundo", "Cultura", "Palabra",
        "Luz", "Vida", "Corazón", "Camino", "Sueño",
        "Libre", "Tiempo", "Noche", "Sol",
    ]

    private static let frenchWords: [String] = [
        "Bonjour", "Merci", "Voyage", "Ami", "Lumière",
        "Vie", "Monde", "Culture", "Parole",
        "Cœur", "Chemin", "Rêve", "Libre", "Nuit",
        "Soleil", "Joie", "Espoir", "Étoile",
    ]

    private static let germanWords: [String] = [
        "Hallo", "Danke", "Freund", "Reise", "Welt",
        "Kultur", "Sprache", "Licht", "Leben",
        "Herz", "Weg", "Traum", "Frei", "Nacht",
        "Sonne", "Freude", "Hoffnung", "Stern",
    ]

    private static let mandarinWords: [String] = [
        "你好", "谢谢", "朋友", "旅行", "世界",
        "文化", "语言", "光", "生活",
        "心", "路", "梦", "自由", "夜",
        "太阳", "快乐", "希望", "星",
    ]

    private static let englishWords: [String] = [
        "Hello", "Journey", "Friend", "World", "Culture",
        "Language", "Light", "Life", "Heart",
        "Dream", "Freedom", "Hope", "Star", "Path",
        "Joy", "Wonder", "Explore", "Discover",
    ]

    private static func wordsForLanguage(_ language: TargetLanguage?) -> [String] {
        guard let language else { return globalWords }
        switch language {
        case .spanish: return spanishWords
        case .french: return frenchWords
        case .german: return germanWords
        case .mandarin: return mandarinWords
        case .english: return englishWords
        }
    }

    // MARK: - Fragment Generation

    static func fragments(
        for language: TargetLanguage?,
        seed: Int,
        count: Int
    ) -> [Fragment] {
        let words = wordsForLanguage(language)
        let s = abs(seed) + 1 // Ensure positive, nonzero

        var result: [Fragment] = []

        for i in 0..<count {
            let wordIndex = (s + i * 7 + i * i) % words.count
            let scaleValue = (s + i * 5 + 1) % 3
            let scale: FragmentScale = scaleValue == 0 ? .large : scaleValue == 1 ? .medium : .small
            let isWarm = (s + i * 3 + 2) % 4 == 0

            let baseOpacity: Double = switch scale {
            case .large: 0.035
            case .medium: 0.05
            case .small: 0.065
            }

            let opacityVariation = Double((s + i * 11) % 20) / 1000.0
            let opacity = baseOpacity + opacityVariation

            result.append(Fragment(
                word: words[wordIndex],
                scale: scale,
                opacity: opacity,
                isWarm: isWarm
            ))
        }

        return result
    }

    // MARK: - Layout

    static func placement(
        index: Int,
        total: Int,
        size: CGSize,
        seed: Int
    ) -> Placement {
        // Distribute fragments across the viewport with intentional spacing.
        // Some can be clipped at edges.
        let hashBase = seed + index * 137

        let xNormalized = Double((hashBase * 37 + 13) % 100) / 100.0
        let yNormalized = Double((hashBase * 53 + 29) % 100) / 100.0

        // Allow overflow for partial clipping
        let x = (xNormalized * size.width * 1.2) - (size.width * 0.1)
        let y = (yNormalized * size.height * 1.1) - (size.height * 0.05)

        let rotation = Double((hashBase * 17) % 25) - 12.5 // -12.5 to +12.5 degrees

        return Placement(x: x, y: y, rotation: rotation)
    }

    // MARK: - Styling

    static func font(for scale: FragmentScale) -> Font {
        switch scale {
        case .large: BolzaTypography.serif(size: 42, weight: .light)
        case .medium: BolzaTypography.serif(size: 28, weight: .regular)
        case .small: BolzaTypography.serif(size: 18, weight: .regular)
        }
    }

    static func fragmentColor(for fragment: Fragment) -> Color {
        fragment.isWarm ? BolzaColor.warmAccent : BolzaColor.textPrimary
    }
}
