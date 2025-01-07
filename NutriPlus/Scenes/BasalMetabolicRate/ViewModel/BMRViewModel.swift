//
//  BMRViewModel.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 29.12.2024.
//

import Foundation

final class BMRViewModel {
  private let assessmentService: AssessmentServiceProtocol
  private var bmrCalculationStrategy: BMRCalculationStrategy
  private(set) var bmrValue: Double = 0.0
  private(set) var targetCalories: Double = 0.0
  private(set) var userAssessmentData: AssessmentModel?

  @Published var bmrValueText: String = "Wait..."
  @Published var targetCaloriesText: String = "Wait..."
  @Published var goalText: String = "Wait..."
  @Published var progressValue: Double = 0.0

  init(assessmentService: AssessmentServiceProtocol, strategy: BMRCalculationStrategy) {
    self.assessmentService = assessmentService
    self.bmrCalculationStrategy = strategy
    fetchUserAssessmentData()
  }

  private func calculateProgressValue() {
    let ratio = targetCalories > 0 ? bmrValue / targetCalories : 0.0
    progressValue = max(0, min(ratio, 1.0))
  }

  private func calculateTargetCalories(for assessment: AssessmentModel) {
    guard let goalRaw = assessment.goal, let fitLevel = assessment.fitLevel else { return }

    let activityLevel = ActivityLevel(rawValue: fitLevel) ?? .sedentary
    let goal = Goal(rawValue: goalRaw) ?? .maintain

    targetCalories = TargetCalorieCalculator.calculateTargetCalories(bmr: bmrValue, activityLevel: activityLevel, goal: goal)
    goalText = TargetCalorieCalculator.goalMessage(for: goal, targetCalories: targetCalories)
    targetCaloriesText = targetCalories.formatted
  }

  private func calculateBMR(for assessment: AssessmentModel) {
    guard
      let weight = assessment.weight,
      let height = assessment.height,
      let age = assessment.age,
      let gender = assessment.gender
    else {
      bmrValueText = "Invalid"
      return
    }

    bmrValue = bmrCalculationStrategy.calculateBMR(
      weight: Double(weight),
      height: Double(height),
      age: Double(age),
      gender: gender
    )
    bmrValueText = bmrValue.formatted
    calculateTargetCalories(for: assessment)
  }

  private func fetchUserAssessmentData() {
    assessmentService.fetchAssessmentData { [weak self] result in
      switch result {
      case .success(let model):
        self?.userAssessmentData = model
        self?.calculateBMR(for: model)
        self?.calculateProgressValue()
      case .failure(let error):
        print(error)
      }
    }
  }
}
