import SwiftUI

/// Bolza primary action button — teal fill, restrained radius.
struct BolzaButton: View {
    let title: String
    var icon: String? = nil
    var style: Style = .primary
    let action: () -> Void

    enum Style {
        case primary
        case secondary
    }

    var body: some View {
        Button(action: action) {
            HStack(spacing: BolzaSpacing.xs) {
                Text(title)
                    .font(BolzaTypography.caption)
                    .fontWeight(.semibold)

                if let icon {
                    Image(systemName: icon)
                        .font(.system(size: 12, weight: .semibold))
                }
            }
            .foregroundStyle(foregroundColor)
            .padding(.horizontal, BolzaSpacing.md)
            .padding(.vertical, BolzaSpacing.sm)
            .background(
                RoundedRectangle(cornerRadius: BolzaRadius.control)
                    .fill(backgroundColor)
            )
            .overlay {
                if style == .secondary {
                    RoundedRectangle(cornerRadius: BolzaRadius.control)
                        .stroke(BolzaColor.border, lineWidth: 1)
                }
            }
        }
        .buttonStyle(.plain)
    }

    private var foregroundColor: Color {
        switch style {
        case .primary: BolzaColor.background
        case .secondary: BolzaColor.textPrimary
        }
    }

    private var backgroundColor: Color {
        switch style {
        case .primary: BolzaColor.brand
        case .secondary: BolzaColor.surfaceElevated
        }
    }
}
