import SwiftUI
import SwiftData

struct OnboardingContainerView: View {
    let router: AppRouter
    @Environment(\.modelContext) private var modelContext
    @State private var viewModel = OnboardingViewModel()

    var body: some View {
        VStack(spacing: 0) {
            // Progress dots
            HStack(spacing: 8) {
                ForEach(OnboardingViewModel.OnboardingStep.allCases, id: \.rawValue) { step in
                    Circle()
                        .fill(step.rawValue <= viewModel.currentStep.rawValue
                              ? Color.accentColor : Color.secondary.opacity(0.3))
                        .frame(width: 10, height: 10)
                }
            }
            .padding(.top, 24)
            .padding(.bottom, 16)

            // Content
            TabView(selection: $viewModel.currentStep) {
                NativeLanguageSelectionView(
                    selectedLanguage: $viewModel.selectedNativeLanguage
                )
                .tag(OnboardingViewModel.OnboardingStep.nativeLanguage)

                LanguageSelectionView(
                    selectedLanguage: $viewModel.selectedTargetLanguage,
                    nativeLanguage: viewModel.selectedNativeLanguage
                )
                .tag(OnboardingViewModel.OnboardingStep.targetLanguage)

                ProficiencySelectionView(
                    selectedProficiency: $viewModel.selectedProficiency
                )
                .tag(OnboardingViewModel.OnboardingStep.proficiency)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .animation(.easeInOut, value: viewModel.currentStep)

            // Bottom buttons
            HStack {
                if viewModel.currentStep.rawValue > 0 {
                    Button("Back") {
                        withAnimation { viewModel.goBack() }
                    }
                    .buttonStyle(.bordered)
                }

                Spacer()

                Button(viewModel.isLastStep ? "Start Learning" : "Continue") {
                    if viewModel.isLastStep {
                        viewModel.createProfile(in: modelContext)
                        router.completeOnboarding()
                    } else {
                        withAnimation { viewModel.advance() }
                    }
                }
                .buttonStyle(.borderedProminent)
                .disabled(!viewModel.canProceed)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 32)
        }
    }
}
