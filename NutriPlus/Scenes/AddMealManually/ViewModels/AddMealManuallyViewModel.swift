//
//  AddMealManuallyViewModel.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 20.12.2024.
//

import Foundation

final class AddMealManuallyViewModel {
  var selectedMealTypeIndex: Int? = nil
  let mealTypes = ["Breakfast", "Dinner", "Snacks"]

  func createMeal(name: String, mealType: String, values: [Int]) -> MealCellViewModel {
    let meal = MealCellViewModel(
      name: name,
      detail: "",
      type: mealType,
      calories: values[0],
      protein: values[1],
      carbs: values[2],
      fat: values[3]
    )

    return meal
  }
}
