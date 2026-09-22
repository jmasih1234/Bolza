import SwiftUI
import SwiftData

struct LessonContainerView: View {
    let nodeID: UUID
    let router: AppRouter
    @Environment(\.modelContext) private var modelContext
    @Environment(TutorService.self) private var tutorService
    @Query private var profiles: [UserProfile]
    @State private var viewModel: LessonViewModel?
    @State private var lessonNode: LessonNode?

    var body: some View {
        Group {
            if let viewModel {
                lessonContent(viewModel)
            } else {
                VStack(spacing: 16) {
                    ProgressView()
                    Text("Preparing lesson...")
                        .foregroundStyle(.secondary)
                }
            }
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Exit") {
                    router.finishLesson()
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                if let vm = viewModel {
                    Text("\(vm.currentExerciseIndex + 1) / \(vm.totalExercises)")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 4)
                        .glassEffect(in: .capsule)
                }
            }
        }
        .task {
            guard viewModel == nil, let profile = profiles.first else { return }
            // Fetch the lesson node
            let descriptor = FetchDescriptor<LessonNode>(
                predicate: #Predicate { $0.id == nodeID }
            )
            if let node = try? modelContext.fetch(descriptor).first {
                lessonNode = node
                let vm = LessonViewModel(
                    tutorService: tutorService,
                    node: node,
                    profile: profile
                )
                viewModel = vm
                await vm.startLesson()
            }
        }
    }

    @ViewBuilder
    private func lessonContent(_ vm: LessonViewModel) -> some View {
        @Bindable var vm = vm
        switch vm.phase {
        case .loading:
            VStack(spacing: 16) {
                ProgressView()
                Text("Your tutor is thinking...")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

        case .intro(let intro):
            ScrollView {
                VStack(spacing: 24) {
                    TutorMessageBubble(text: intro.greeting)
                    TutorMessageBubble(text: intro.overview)

                    VStack(spacing: 8) {
                        Text("Bridge Word")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        Text(intro.bridgeWord)
                            .font(.title)
                            .fontWeight(.bold)
                        Text(intro.bridgeExplanation)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                    .glassEffect(.regular.tint(.blue), in: .rect(cornerRadius: 16))

                    Button("Begin Lesson") {
                        Task { await vm.nextExercise() }
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                }
                .padding()
            }

        case .exercise(let exercise, _):
            ScrollView {
                VStack(spacing: 20) {
                    TutorMessageBubble(text: exercise.conceptExplanation)

                    VStack(spacing: 8) {
                        Text("Translate this:")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        Text(exercise.sourcePhrase)
                            .font(.title3)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .glassEffect(in: .rect(cornerRadius: 16))

                    UserResponseField(
                        text: $vm.userInput,
                        hint: exercise.thinkingHint,
                        showInputImmediately: false,
                        onReady: { vm.readyToAnswer(exercise) },
                        onSubmit: { Task { await vm.submitAnswer(exercise) } }
                    )
                }
                .padding()
            }

        case .awaitingInput(let exercise):
            ScrollView {
                VStack(spacing: 20) {
                    TutorMessageBubble(text: exercise.conceptExplanation)

                    VStack(spacing: 8) {
                        Text("Translate this:")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        Text(exercise.sourcePhrase)
                            .font(.title3)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .glassEffect(in: .rect(cornerRadius: 16))

                    UserResponseField(
                        text: $vm.userInput,
                        hint: exercise.thinkingHint,
                        showInputImmediately: true,
                        onReady: {},
                        onSubmit: { Task { await vm.submitAnswer(exercise) } }
                    )
                }
                .padding()
            }

        case .evaluating:
            VStack(spacing: 16) {
                ProgressView()
                Text("Checking your answer...")
                    .foregroundStyle(.secondary)
            }

        case .feedback(let feedback, _):
            FeedbackOverlayView(
                feedback: feedback,
                xpEarned: feedback.evaluation == "correct" ? AppConstants.baseXPPerExercise : 2,
                onContinue: { Task { await vm.proceedAfterFeedback() } }
            )

        case .summary(let summary):
            LessonCompleteView(
                summary: summary,
                correctCount: vm.correctCount,
                totalExercises: vm.totalExercises,
                xpEarned: vm.xpEarned,
                onFinish: {
                    if let node = lessonNode {
                        vm.completeLesson(node: node, modelContext: modelContext)
                    }
                    router.finishLesson()
                }
            )

        case .error(let message):
            VStack(spacing: 16) {
                Image(systemName: "exclamationmark.triangle")
                    .font(.largeTitle)
                    .foregroundStyle(.orange)
                Text(message)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.secondary)
                Button("Try Again") {
                    Task { await vm.startLesson() }
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
        }
    }
}
