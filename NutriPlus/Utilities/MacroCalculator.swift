//
//  MacroCalculator.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 7.01.2025.
//

import Foundation

struct MacroCalculator {
  let proteinInGrams: Double
  let carbsInGrams: Double
  let fatInGrams: Double

  func calculateMacroDistribution() -> (proteinPercentage: Double, carbPercentage: Double, fatPercentage: Double) {
    let proteinCalories = proteinInGrams * 4.0
    let carbCalories = carbsInGrams * 4.0
    let fatCalories = fatInGrams * 9.0
    let totalCalories = proteinCalories + carbCalories + fatCalories

    guard totalCalories != 0 else { return (0, 0, 0) }

    let proteinPercentage = (proteinCalories / totalCalories) * 100.0
    let carbPercentage = (carbCalories / totalCalories) * 100.0
    let fatPercentage = (fatCalories / totalCalories) * 100.0

    return (proteinPercentage, carbPercentage, fatPercentage)
  }
}
