//
//  HeightSelectionViewModel.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 26.12.2024.
//

import Foundation

final class HeightSelectionViewModel {
  // MARK: - Published Properties
  @Published var heightInCm: Float
  @Published var selectedUnit: HeightUnit

  init(heightInCm: Float = 170.0, selectedUnit: HeightUnit = .centimeter) {
    self.heightInCm = heightInCm
    self.selectedUnit = selectedUnit
  }

  func updateHeight(_ height: Float) {
    self.heightInCm = height
  }

  func updateUnit(_ unit: HeightUnit) {
    self.selectedUnit = unit
  }

  func heightString() -> String {
    switch selectedUnit {
    case .centimeter:
      return String(format: "%.0f cm", heightInCm)
    case .feet:
      let feet = Int(heightInCm / 30.48)
      let inches = Int((heightInCm - (Float(feet) * 30.48)) / 2.54)
      return String(format: "%d' %d\"", feet, inches)
    }
  }
}
