import SwiftUI

struct TutorMessageBubble: View {
    let text: String

    var body: some View {
        HStack {
            HStack(alignment: .top, spacing: 12) {
                Image(systemName: "person.circle.fill")
                    .font(.title2)
                    .foregroundStyle(.tint)

                Text(text)
                    .font(.body)
            }
            .padding()
            .glassEffect(in: .rect(cornerRadius: 16))

            Spacer(minLength: 40)
        }
    }
}
