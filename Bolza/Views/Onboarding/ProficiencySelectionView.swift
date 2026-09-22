import SwiftUI

struct ProficiencySelectionView: View {
    @Binding var selectedProficiency: ProficiencyLevel?

    var body: some View {
        VStack(spacing: 24) {
            Text("What's your level?")
                .font(.title)
                .fontWeight(.bold)

            Text("We'll start your lessons at the right place")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)

            VStack(spacing: 16) {
                ForEach(ProficiencyLevel.allCases) { level in
                    ProficiencyCard(
                        level: level,
                        isSelected: selectedProficiency == level,
                        onTap: {
                            withAnimation(.spring(duration: 0.3)) {
                                selectedProficiency = level
                            }
                        }
                    )
                }
            }
            .padding(.horizontal)

            Spacer()
        }
        .padding(.top, 32)
    }
}

private struct ProficiencyCard: View {
    let level: ProficiencyLevel
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 16) {
                Image(systemName: level.icon)
                    .font(.title2)
                    .frame(width: 44, height: 44)
                    .background(Circle().fill(Color.accentColor.opacity(0.1)))

                VStack(alignment: .leading, spacing: 4) {
                    Text(level.displayName)
                        .font(.headline)
                        .foregroundStyle(.primary)
                    Text(level.description)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                Spacer()

                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundStyle(Color.accentColor)
                        .font(.title3)
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(isSelected ? Color.accentColor.opacity(0.1) : Color(.secondarySystemBackground))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(isSelected ? Color.accentColor : Color.clear, lineWidth: 2)
            )
        }
        .buttonStyle(.plain)
    }
}
