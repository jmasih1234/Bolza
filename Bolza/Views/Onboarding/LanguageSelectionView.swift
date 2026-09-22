import SwiftUI

struct LanguageSelectionView: View {
    @Binding var selectedLanguage: TargetLanguage?
    let nativeLanguage: NativeLanguage?

    private var availableLanguages: [TargetLanguage] {
        TargetLanguage.allCases.filter { $0.rawValue != nativeLanguage?.rawValue }
    }

    var body: some View {
        VStack(spacing: 24) {
            Text("What do you want to learn?")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)

            Text("Choose your target language")
                .font(.subheadline)
                .foregroundStyle(.secondary)

            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                ForEach(availableLanguages) { language in
                    Button {
                        withAnimation(.spring(duration: 0.3)) {
                            selectedLanguage = language
                        }
                    } label: {
                        VStack(spacing: 8) {
                            Text(language.flag)
                                .font(.system(size: 40))
                            Text(language.displayName)
                                .font(.headline)
                                .foregroundStyle(.primary)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 20)
                        .background {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(selectedLanguage == language
                                      ? Color.accentColor.opacity(0.15)
                                      : Color(.secondarySystemBackground))
                        }
                        .overlay {
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(selectedLanguage == language
                                        ? Color.accentColor : Color.clear, lineWidth: 2)
                        }
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal)

            Spacer()
        }
        .padding(.top, 32)
    }
}
