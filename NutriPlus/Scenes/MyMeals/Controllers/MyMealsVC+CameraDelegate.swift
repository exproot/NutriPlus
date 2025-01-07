//
//  MyMealsVC+CameraDelegate.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 7.01.2025.
//

import Foundation

extension MyMealsViewController: CameraViewControllerDelegate {
  func didScanMealWithAI(_ controller: CameraViewController, meal: Meal) {
    guard let selectedDateIndex = viewModel.selectedIndex else { return }
    let date = viewModel.dateItems[selectedDateIndex].dateString
    let mealCellViewModel = MealCellViewModel(meal: meal)

    viewModel.addMeal(meal: mealCellViewModel, date: date) { [weak self] in
      self?.updateMealSection()
    }
  }

  func didCancelCapturing(_ controller: CameraViewController) {
    print("d")
  }
}
