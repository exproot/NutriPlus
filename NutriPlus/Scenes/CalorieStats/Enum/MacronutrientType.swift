//
//  MacronutrientType.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 7.01.2025.
//

import UIKit

enum MacronutrientType: Int, CaseIterable {
  case protein
  case carbs
  case fat

  var text: String {
    switch self {
    case .protein:
      return "Protein"
    case .carbs:
      return "Carbs"
    case .fat:
      return "Fat"
    }
  }

  var color: UIColor {
    switch self {
    case .protein:
      return .systemGreen
    case .carbs:
      return .systemYellow
    case .fat:
      return .systemRed
    }
  }
}
