//
//  TargetCalorieCalculator.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 29.12.2024.
//

import Foundation

enum TargetCalorieCalculator {
  static func calculateTargetCalories(bmr: Double, activityLevel: ActivityLevel, goal: Goal) -> Double {
    let tdee = bmr * activityLevel.multiplier

    switch goal {
    case .bulk:
      return tdee + 500
    case .cut:
      return tdee - 500
    case .maintain:
      return tdee
    }
  }

  static func goalMessage(for goal: Goal, targetCalories: Double) -> String {
    switch goal {
    case .bulk:
      return "In order to gain weight, you should aim \(Int(targetCalories.rounded())) kcal/day."
    case .cut:
      return "In order to lose weight, you should aim \(Int(targetCalories.rounded())) kcal/day."
    case .maintain:
      return "In order to maintain your weight, you should aim \(Int(targetCalories.rounded())) kcal/day."
    }
  }
}
