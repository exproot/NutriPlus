//
//  WeightSelectionViewModel.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 26.12.2024.
//

import Foundation

enum WeightUnit {
  case kg
  case lbs
}

final class WeightSelectionViewModel {
  @Published var weightInKg: Float
  @Published var selectedUnit: WeightUnit

  init(weightInKg: Float = 60.0, selectedUnit: WeightUnit = .kg) {
    self.weightInKg = weightInKg
    self.selectedUnit = selectedUnit
  }

  func updateWeight(_ weight: Float) {
    self.weightInKg = weight
  }

  func updateUnit(_ unit: WeightUnit) {
    self.selectedUnit = unit
  }

  func weightString() -> String {
    switch selectedUnit {
    case .kg:
      return String(format: "\(Int(weightInKg)) kg")
    case .lbs:
      let lbs = Int(weightInKg * 2.20462)
      return String(format: "\(Int(lbs)) lbs")
    }
  }
}
