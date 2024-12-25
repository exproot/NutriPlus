//
//  MyMealsController+MealCellDelegate.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 25.12.2024.
//

import Foundation

// MARK: - MealCellDelegate
extension MyMealsViewController: MealCellDelegate {
  func didTapOnDelete(for meal: MealCellViewModel?) {
    guard let selectedDateIndex = viewModel.selectedIndex else { return }
    let selectedDate = viewModel.dateItems[selectedDateIndex].dateString
    let currentDate = Date().toFormattedString()

    if selectedDate == currentDate, let meal = meal {
      viewModel.deleteMeal(mealId: meal.id, dateString: selectedDate) { [weak self] in
        self?.updateMealSection()
      }
    } else {
      self.showAlert(title: "Can't Delete", message: "You can only delete meals that appears in the current day.")
    }
  }

  func didTapOnInfo(for meal: MealCellViewModel?) {
    if let meal = meal {
      pushChatController(with: meal.name)
    }
  }
}
