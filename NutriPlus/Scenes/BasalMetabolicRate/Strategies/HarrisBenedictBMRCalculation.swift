//
//  HarrisBenedictBMRCalculation.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 29.12.2024.
//

import Foundation

final class HarrisBenedictBMRCalculation: BMRCalculationStrategy {
  func calculateBMR(weight: Double, height: Double, age: Double, gender: Bool) -> Double {
    if gender {
      return 88.362 + (13.397 * weight) + (4.799 * height) - (5.677 * age)
    } else {
      return 447.593 + (9.247 * weight) + (3.098 * height) - (4.330 * age)
    }
  }
}
