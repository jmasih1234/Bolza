import SwiftUI

struct UserResponseField: View {
    @Binding var text: String
    let hint: String
    var showInputImmediately: Bool = false
    var onReady: () -> Void
    var onSubmit: () -> Void

    @State private var showInput: Bool

    init(text: Binding<String>, hint: String, showInputImmediately: Bool, onReady: @escaping () -> Void, onSubmit: @escaping () -> Void) {
        self._text = text
        self.hint = hint
        self.showInputImmediately = showInputImmediately
        self.onReady = onReady
        self.onSubmit = onSubmit
        self._showInput = State(initialValue: showInputImmediately)
    }

    var body: some View {
        VStack(spacing: 16) {
            if !showInput {
                // Thinking phase
                VStack(spacing: 12) {
                    Image(systemName: "brain.head.profile")
                        .font(.largeTitle)
                        .foregroundStyle(.purple)

                    Text("Think about it...")
                        .font(.headline)

                    Text(hint)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)

                    Button("I'm ready to answer") {
                        withAnimation(.spring(duration: 0.4)) {
                            showInput = true
                        }
                        onReady()
                    }
                    .buttonStyle(.borderedProminent)
                    .padding(.top, 8)
                }
                .padding()
                .glassEffect(.regular.tint(.purple.opacity(0.3)), in: .rect(cornerRadius: 20))
            } else {
                // Input phase
                VStack(spacing: 12) {
                    TextField("Type your translation...", text: $text)
                        .textFieldStyle(.roundedBorder)
                        .font(.body)
                        .onSubmit(onSubmit)

                    Button("Submit Answer") {
                        onSubmit()
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    .disabled(text.trimmingCharacters(in: .whitespaces).isEmpty)
                }
                .padding()
            }
        }
    }
}
