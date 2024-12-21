//
//  MealCellViewModel.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 7.11.2024.
//

import Foundation

struct MealCellViewModel: Hashable {
  var id: String
  let name: String
  let detail: String
  let type: String
  let calories: Int
  let protein, carbs, fat: Int

  init(id: String = UUID().uuidString, name: String, detail: String, type: String, calories: Int, protein: Int, carbs: Int, fat: Int) {
    self.id = id
    self.name = name
    self.detail = detail
    self.type = type
    self.calories = calories
    self.protein = protein
    self.carbs = carbs
    self.fat = fat
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}
