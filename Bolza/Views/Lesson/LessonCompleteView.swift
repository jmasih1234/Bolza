import SwiftUI

struct LessonCompleteView: View {
    let summary: LessonSummary
    let correctCount: Int
    let totalExercises: Int
    let xpEarned: Int
    let onFinish: () -> Void

    @State private var showContent = false

    private var scorePercent: Int {
        guard totalExercises > 0 else { return 0 }
        return (correctCount * 100) / totalExercises
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 28) {
                // Trophy
                Image(systemName: scorePercent == 100 ? "trophy.fill" : "star.fill")
                    .font(.system(size: 64))
                    .foregroundStyle(scorePercent == 100 ? .yellow : .orange)
                    .scaleEffect(showContent ? 1 : 0.3)
                    .opacity(showContent ? 1 : 0)

                Text("Lesson Complete!")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                // Score
                VStack(spacing: 8) {
                    Text("\(scorePercent)%")
                        .font(.system(size: 48, weight: .bold, design: .rounded))
                        .foregroundStyle(scorePercent >= 80 ? .green : scorePercent >= 60 ? .orange : .red)

                    Text("\(correctCount) of \(totalExercises) correct")
                        .foregroundStyle(.secondary)
                }
                .padding()
                .glassEffect(in: .rect(cornerRadius: 20))

                // Congratulation
                Text(summary.congratulation)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                // Patterns practiced
                VStack(alignment: .leading, spacing: 8) {
                    Text("Patterns Practiced")
                        .font(.headline)
                    Text(summary.patternsPracticed)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .glassEffect(.regular.tint(.blue), in: .rect(cornerRadius: 16))

                // Improvement tip
                VStack(spacing: 4) {
                    Text("Tip for next time")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text(summary.improvementTip)
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                }
                .padding()

                // XP earned
                XPBadge(amount: xpEarned)

                Button("Continue") {
                    onFinish()
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
            }
            .padding()
        }
        .onAppear {
            withAnimation(.spring(duration: 0.6, bounce: 0.3).delay(0.2)) {
                showContent = true
            }
        }
    }
}
