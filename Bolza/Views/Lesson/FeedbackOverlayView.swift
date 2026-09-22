import SwiftUI

struct FeedbackOverlayView: View {
    let feedback: TutorFeedback
    let xpEarned: Int
    let onContinue: () -> Void

    private var isCorrect: Bool { feedback.evaluation == "correct" }
    private var isPartial: Bool { feedback.evaluation == "partial" }

    private var resultIcon: String {
        if isCorrect { return "checkmark.circle.fill" }
        if isPartial { return "exclamationmark.circle.fill" }
        return "xmark.circle.fill"
    }

    private var resultColor: Color {
        if isCorrect { return .green }
        if isPartial { return .orange }
        return .red
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Result icon
                Image(systemName: resultIcon)
                    .font(.system(size: 56))
                    .foregroundStyle(resultColor)

                Text(isCorrect ? "Correct!" : isPartial ? "Almost!" : "Not quite")
                    .font(.title2)
                    .fontWeight(.bold)

                // Explanation
                Text(feedback.explanation)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding()
                    .glassEffect(in: .rect(cornerRadius: 16))

                // Show correct answer if not fully correct
                if !isCorrect {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Correct answer:")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        Text(feedback.correctedTranslation)
                            .font(.title3)
                            .fontWeight(.semibold)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .glassEffect(.regular.tint(.blue), in: .rect(cornerRadius: 12))
                }

                // Reinforcement phrase
                VStack(spacing: 4) {
                    Text("Try this next time:")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text(feedback.reinforcementPhrase)
                        .font(.subheadline)
                        .italic()
                }
                .padding()

                // XP badge
                XPBadge(amount: xpEarned)

                Button("Continue") {
                    onContinue()
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
            }
            .padding()
        }
    }
}
