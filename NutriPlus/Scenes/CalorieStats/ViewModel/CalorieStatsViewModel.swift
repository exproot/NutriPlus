//
//  CalorieStatsViewModel.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 7.01.2025.
//

import Foundation
import Combine

final class CalorieStatsViewModel {
  private var meals: [MealCellViewModel]
  private(set) var macronutrientAmounts = [0.0, 0.0, 0.0]

  @Published var totalCaloriesText: String = "... kcal"
  @Published var proteinPercentage: Double = 0.0
  @Published var carbPercentage: Double = 0.0
  @Published var fatPercentage: Double = 0.0

  init(meals: [MealCellViewModel]) {
    self.meals = meals
    updateCalorieStats()
  }

  private func updateCalorieStats() {
    let totalCalories = meals.reduce(0) { $0 + $1.calories }
    totalCaloriesText = "\(totalCalories) kcal"

    let totalMacronutrients = meals.reduce((protein: 0.0, carbs: 0.0, fat: 0.0)) { (result, meal) in
      (protein: result.protein + Double(meal.protein),
        carbs: result.carbs + Double(meal.carbs),
        fat: result.fat + Double(meal.fat))
    }
    macronutrientAmounts = [totalMacronutrients.protein, totalMacronutrients.carbs, totalMacronutrients.fat]

    let macroCalculator = MacroCalculator(
      proteinInGrams: totalMacronutrients.protein,
      carbsInGrams: totalMacronutrients.carbs,
      fatInGrams: totalMacronutrients.fat
    )
    let macroDistribution = macroCalculator.calculateMacroDistribution()

    proteinPercentage = macroDistribution.proteinPercentage
    carbPercentage = macroDistribution.carbPercentage
    fatPercentage = macroDistribution.fatPercentage
  }

  private func resetPercentages() {
    proteinPercentage = 0.0
    carbPercentage = 0.0
    fatPercentage = 0.0
  }
}
