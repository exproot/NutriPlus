//
//  AddNewMealDelegate.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 20.12.2024.
//

import Foundation

protocol AddNewMealControllerDelegate: AnyObject {
  func addNewMealController(didAddManually meal: MealCellViewModel)
  func addNewMealController(didAddWithAI meal: Meal)
}
