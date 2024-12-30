//
//  MyMealsVC+AddNewMealDelegate.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 30.12.2024.
//

import Foundation

// MARK: - AddNewMealControllerDelegate
extension MyMealsViewController: AddNewMealControllerDelegate {
  func addNewMealController(didAddWithAI meal: Meal) {
    guard let selectedDateIndex = viewModel.selectedIndex else { return }
    let date = viewModel.dateItems[selectedDateIndex].dateString
    let mealCellViewModel = MealCellViewModel(meal: meal)

    viewModel.addMeal(meal: mealCellViewModel, date: date) { [weak self] in
      self?.updateMealSection()
    }
  }

  func addNewMealController(didAddManually meal: MealCellViewModel) {
    guard let selectedDateIndex = viewModel.selectedIndex else { return }
    let date = viewModel.dateItems[selectedDateIndex].dateString

    viewModel.addMeal(meal: meal, date: date) { [weak self] in
      self?.updateMealSection()
    }
  }
}
