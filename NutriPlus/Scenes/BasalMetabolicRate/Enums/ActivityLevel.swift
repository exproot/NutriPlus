//
//  ActivityLevel.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 29.12.2024.
//

import Foundation

enum ActivityLevel: Int {
  case sedentary = 1
  case lightlyActive
  case moderatelyActive
  case athletic
  case veryAthletic

  var multiplier: Double {
    switch self {
    case .sedentary: return 1.2
    case .lightlyActive: return 1.375
    case .moderatelyActive: return 1.55
    case .athletic: return 1.725
    case .veryAthletic: return 1.9
    }
  }

  var description: String {
    switch self {
    case .sedentary:
      return "Sedentary"
    case .lightlyActive:
      return "Lightly Active"
    case .moderatelyActive:
      return "Moderately Active"
    case .athletic:
      return "Athletic"
    case .veryAthletic:
      return "Very Athletic"
    }
  }
}
