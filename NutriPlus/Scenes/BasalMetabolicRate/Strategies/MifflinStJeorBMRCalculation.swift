//
//  MifflinStJeorBMRCalculation.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 29.12.2024.
//

import Foundation

final class MifflinStJeorBMRCalculation: BMRCalculationStrategy {
  func calculateBMR(weight: Double, height: Double, age: Double, gender: Bool) -> Double {
    if gender {
      return 10 * weight + 6.25 * height - 5 * age + 5
    } else {
      return 10 * weight + 6.25 * height - 5 * age - 161
    }
  }
}
