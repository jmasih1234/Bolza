import SwiftUI

/// Restrained section header with optional trailing action.
struct BolzaSectionHeader: View {
    let title: String
    var trailingText: String? = nil
    var trailingAction: (() -> Void)? = nil

    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Text(title.uppercased())
                .font(BolzaTypography.micro)
                .foregroundStyle(BolzaColor.textSecondary)
                .tracking(1.2)

            Spacer()

            if let trailingText, let trailingAction {
                Button(action: trailingAction) {
                    Text(trailingText)
                        .font(BolzaTypography.micro)
                        .foregroundStyle(BolzaColor.brand)
                }
            }
        }
    }
}
