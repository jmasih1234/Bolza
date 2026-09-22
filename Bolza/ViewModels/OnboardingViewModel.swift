import Observation
import SwiftData
import Foundation

@Observable
final class OnboardingViewModel {
    var selectedNativeLanguage: NativeLanguage?
    var selectedTargetLanguage: TargetLanguage?
    var selectedProficiency: ProficiencyLevel?
    var currentStep: OnboardingStep = .nativeLanguage

    enum OnboardingStep: Int, CaseIterable {
        case nativeLanguage = 0
        case targetLanguage = 1
        case proficiency = 2
    }

    var canProceed: Bool {
        switch currentStep {
        case .nativeLanguage: selectedNativeLanguage != nil
        case .targetLanguage: selectedTargetLanguage != nil
        case .proficiency: selectedProficiency != nil
        }
    }

    var isLastStep: Bool {
        currentStep == .proficiency
    }

    func advance() {
        guard let nextStep = OnboardingStep(rawValue: currentStep.rawValue + 1) else { return }
        currentStep = nextStep
    }

    func goBack() {
        guard let prevStep = OnboardingStep(rawValue: currentStep.rawValue - 1) else { return }
        currentStep = prevStep
    }

    func createProfile(in context: ModelContext) {
        guard let native = selectedNativeLanguage,
              let target = selectedTargetLanguage,
              let proficiency = selectedProficiency else { return }

        let profile = UserProfile(nativeLanguage: native, activeLanguage: target)
        context.insert(profile)

        let course = LanguageCourse(language: target, proficiency: proficiency)
        course.userProfile = profile

        let topics = target.lessonTopics
        for (index, topic) in topics.enumerated() {
            let node = LessonNode(
                orderIndex: index,
                topicKey: topic.topicKey,
                title: topic.title,
                subtitle: topic.subtitle
            )
            node.isUnlocked = index <= proficiency.startingLessonIndex
            node.course = course
        }

        try? context.save()
    }
}
