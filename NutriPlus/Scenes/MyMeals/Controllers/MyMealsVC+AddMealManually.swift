//
//  MyMealsVC+AddMealManually.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 30.12.2024.
//

import Foundation

// MARK: - AddMealManuallyDelegate
extension MyMealsViewController: AddMealManuallyDelegate {
  func didAddManually(_ controller: AddMealManuallyViewController, meal: MealCellViewModel) {
    guard let selectedDateIndex = viewModel.selectedIndex else { return }
    let date = viewModel.dateItems[selectedDateIndex].dateString

    viewModel.addMeal(meal: meal, date: date) { [weak self] in
      self?.updateMealSection()
    }
  }
}
