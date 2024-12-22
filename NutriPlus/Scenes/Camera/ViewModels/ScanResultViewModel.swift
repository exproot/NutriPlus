//
//  ScanResultViewModel.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 22.12.2024.
//

import Foundation

final class ScanResultViewModel {
  var meal: Meal?

  init(meal: Meal?) {
    self.meal = meal
  }

  func getNutrientValues() -> [Int] {
    guard let meal = meal else { return [] }

    let values = [
      meal.nutrients.protein,
      meal.nutrients.carbs,
      meal.nutrients.fats
    ]
    
    return values
  }
}
