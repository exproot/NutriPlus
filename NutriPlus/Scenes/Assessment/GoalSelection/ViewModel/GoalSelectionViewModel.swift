//
//  GoalSelectionViewModel.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 24.10.2024.
//

import Foundation
import Combine

final class GoalSelectionViewModel {
  let assessmentService: AssessmentService

  init(assessmentService: AssessmentService) {
    self.assessmentService = assessmentService
  }

  @Published var selectedGoal: String? = nil

  let fitnessGoals = [
    "⏲️ I wanna lose weight",
    "🤖 I wanna try AI Coach",
    "💪🏻 I wanna get bulks",
    "🏃‍♂️ I wanna gain endurance",
    "📱 Just trying out the app!"
  ]

  func selectGoal(at index: Int) {
    guard index >= 0 && index < fitnessGoals.count else { return }
    selectedGoal = fitnessGoals[index]
  }

  func addAssessment(assessment: AssessmentModel, completion: @escaping () -> Void) {
    assessmentService.saveAssessmentData(assessment) { result in
      switch result {
      case .success:
        completion()
      case .failure(let error):
        print(error)
      }
    }
  }
}

