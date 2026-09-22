import SwiftUI

/// Compact language indicator — small flag + name.
struct BolzaLanguageBadge: View {
    let language: TargetLanguage

    var body: some View {
        HStack(spacing: BolzaSpacing.xxs) {
            Text(language.flag)
                .font(.system(size: 14))
            Text(language.displayName)
                .font(BolzaTypography.caption)
                .foregroundStyle(BolzaColor.textSecondary)
        }
    }
}
