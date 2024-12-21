//
//  Meal.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 18.12.2024.
//

import Foundation

struct Meal: Codable {
  let name, detail: String
  let calories: Int
  let nutrients: Nutrients
}

struct Nutrients: Codable {
  let protein, fats, carbs: Int
}
