//
//  BMIViewModel.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 28.12.2024.
//

import UIKit

final class BMIViewModel {
  let assessmentService: AssessmentServiceProtocol
  var userAssessmentData: AssessmentModel?
  var bmiValue: Double = 0.0

  @Published var bmiValueText: String = ""
  @Published var bmiCategoryText: String = ""
  @Published var bmiGradientColors: [UIColor] = []

  init(assessmentService: AssessmentServiceProtocol) {
    self.assessmentService = assessmentService
    fetchUserAssessmentData()
  }

  private func classifyBMI(_ bmi: Double) {
    let category: BMICategory

    switch bmi {
    case ..<18.5:
      category = .underweight
    case 18.5..<24.9:
      category = .normal
    case 25.0..<29.9:
      category = .overweight
    default:
      category = .obese
    }

    bmiValueText = "\(bmi)"
    bmiCategoryText = category.description
    bmiGradientColors = category.colors
  }

  func calculateBMI() {
    if let weight = userAssessmentData?.weight, let height = userAssessmentData?.heightInMeters {
      bmiValue = Double(weight) / pow(height, 2)
      classifyBMI(bmiValue.roundToOneDecimal())
    }
  }

  private func fetchUserAssessmentData() {
    assessmentService.fetchAssessmentData { [weak self] result in
      switch result {
      case .success(let model):
        self?.userAssessmentData = model
        self?.calculateBMI()
      case .failure(let error):
        print(error)
      }
    }
  }
}
