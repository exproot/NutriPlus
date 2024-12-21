//
//  AddNewMealViewController+Selectors.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 21.12.2024.
//

import Foundation

// MARK: - Selectors
extension AddNewMealViewController {
  @objc func handleContinueButton() {
    guard
      let name = mealNameTextField.text, !name.isEmpty,
      let selectedTypeIndex = viewModel.selectedMealTypeIndex
    else {
      return
    }

    let sliderValues = sliderStackView.extractSliderValues()
    let mealType = viewModel.mealTypes[selectedTypeIndex]
    let meal = viewModel.createMeal(name: name, mealType: mealType, values: sliderValues)

    delegate?.addNewMealController(didAddManually: meal)
    navigationController?.popViewController(animated: true)
  }
}
