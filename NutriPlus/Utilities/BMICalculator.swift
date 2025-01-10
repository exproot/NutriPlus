//
//  BMICalculator.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 7.01.2025.
//

import Foundation

enum BMICalculator {
  static func calculateBMI(height: Double, weight: Double) -> Double {
    return weight / pow(height, 2)
  }

  static func classifyBMI(_ bmi: Double) -> BMICategory {
    switch bmi {
    case ..<18.5:
      return .underweight
    case 18.5..<24.9:
      return .normal
    case 25.0..<29.9:
      return .overweight
    default:
      return .obese
    }
  }
}

