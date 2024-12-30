//
//  FitSelectionViewModel.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 26.12.2024.
//

import Foundation
import Combine

final class FitSelectionViewModel {
  @Published var fitnessLevel = 3

  func fitnessDescription(for fitnessLevel: Int) -> String {
    switch fitnessLevel {
    case 1:
      return "Sedentary"
    case 2:
      return "Lightly Active"
    case 3:
      return "Somewhat Athletic"
    case 4:
      return "Athletic"
    case 5:
      return "Very Athletic"
    default:
      return "Unknown"
    }
  }

  func setFitnessLevel(to level: Int) {
    fitnessLevel = level
  }
}
