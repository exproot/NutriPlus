//
//  AddMealManuallyDelegate.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 20.12.2024.
//

import Foundation

protocol AddMealManuallyDelegate: AnyObject {
  func didAddManually(_ controller: AddMealManuallyViewController, meal: MealCellViewModel)
}
