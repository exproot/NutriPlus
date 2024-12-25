//
//  MyMealsViewController+Selectors.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 21.12.2024.
//

import UIKit

// MARK: - Selectors
extension MyMealsViewController {
  @objc func handleAddButton() {
    guard viewModel.isSelectedDateToday() else {
      print("you can only add meals to the current day!")
      return
    }
    let addMealController = AddNewMealViewController()
    addMealController.delegate = self
    navigationController?.pushViewController(addMealController, animated: true)
  }
}
