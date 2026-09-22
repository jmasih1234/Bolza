import SwiftUI

/// Bolza semantic color system.
///
/// Palette:
///   Midnight     #090D0E   — primary environment
///   Graphite     #151B1C   — surfaces
///   Elevated     #1C2425   — elevated surfaces
///   Teal         #18BFBA   — primary brand / interaction
///   Seafoam      #82B8AE   — secondary information
///   Sand         #C8A982   — cultural warmth
///   Tan          #E3D1B7   — warm light accent
///   Off White    #F1F0EC   — primary typography
///
/// Target balance:
///   70-80% dark neutrals
///   10-15% typography / light surfaces
///   5-10% teal
///   5-10% warm sand / tan
enum BolzaColor {

    // MARK: - Backgrounds

    /// Midnight — primary app environment.
    static let background = Color(hex: 0x090D0E)

    /// Graphite — card / section surfaces.
    static let surface = Color(hex: 0x151B1C)

    /// Elevated Graphite — raised or interactive surfaces.
    static let surfaceElevated = Color(hex: 0x1C2425)

    // MARK: - Brand

    /// Teal — primary interaction color. Use sparingly.
    static let brand = Color(hex: 0x18BFBA)

    /// Seafoam — secondary accent.
    static let seafoam = Color(hex: 0x82B8AE)

    // MARK: - Warmth

    /// Sand — cultural / editorial warmth.
    static let warmAccent = Color(hex: 0xC8A982)

    /// Tan — warm light accent.
    static let warmLight = Color(hex: 0xE3D1B7)

    // MARK: - Typography

    /// Off White — primary text.
    static let textPrimary = Color(hex: 0xF1F0EC)

    /// Muted — secondary text.
    static let textSecondary = Color(hex: 0x8A9193)

    /// Muted — tertiary / disabled text.
    static let textTertiary = Color(hex: 0x5B6567)

    // MARK: - Borders

    static let border = Color.white.opacity(0.06)
    static let borderSubtle = Color.white.opacity(0.03)

    // MARK: - Semantic

    static let success = Color(hex: 0x4CAF7D)
    static let warning = Color(hex: 0xE8A84C)
    static let destructive = Color(hex: 0xD9534F)
}

// MARK: - Hex Initializer

extension Color {
    init(hex: UInt, opacity: Double = 1.0) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8) & 0xFF) / 255,
            blue: Double(hex & 0xFF) / 255,
            opacity: opacity
        )
    }
}
