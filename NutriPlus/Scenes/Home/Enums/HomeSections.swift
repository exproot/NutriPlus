//
//  HomeSections.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 2.01.2025.
//

import Foundation

enum HomeSections: Int, CaseIterable {
  case calorieGoal
  case condition
  case ai

  var sectionTitle: String {
    switch self {
    case .calorieGoal:
      return "Calorie Goal"
    case .condition:
      return "Body Condition"
    case .ai:
      return "Virtual Nutritionist"
    }
  }
}
