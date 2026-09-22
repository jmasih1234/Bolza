import SwiftUI

/// Bolza typography system.
///
/// Editorial serif — for screen titles, the wordmark, cultural statements,
/// language phrases. Uses Georgia as a development stand-in.
/// TODO: Replace with a licensed editorial serif (e.g. Playfair Display, Lora, or similar).
///
/// System sans — SF Pro via SwiftUI `.font(.system(...))` for all UI:
/// buttons, metadata, navigation, progress, controls.
enum BolzaTypography {

    // MARK: - Serif (Editorial / Cultural)

    /// The serif font family name. Change this single value
    /// when a licensed serif is added to the project.
    private static let serifFamily = "Georgia"

    static func serif(size: CGFloat, weight: Font.Weight = .regular) -> Font {
        .custom(serifFamily, size: size).weight(weight)
    }

    /// Large editorial title — greeting, lesson headings.
    static let displayLarge = Font.custom(serifFamily, size: 32).weight(.bold)

    /// Medium editorial — section statements.
    static let displayMedium = Font.custom(serifFamily, size: 24).weight(.semibold)

    /// Small editorial — card titles, cultural phrases.
    static let displaySmall = Font.custom(serifFamily, size: 20).weight(.medium)

    /// Editorial body — quotes, editorial paragraphs.
    static let editorialBody = Font.custom(serifFamily, size: 17)

    // MARK: - Sans (Functional UI)

    /// Section header.
    static let heading = Font.system(size: 15, weight: .semibold)

    /// Card titles.
    static let titleMedium = Font.system(size: 17, weight: .semibold)

    /// Body copy.
    static let body = Font.system(size: 15, weight: .regular)

    /// Small labels, metadata.
    static let caption = Font.system(size: 13, weight: .medium)

    /// Very small — tags, badges.
    static let micro = Font.system(size: 11, weight: .medium)
}
