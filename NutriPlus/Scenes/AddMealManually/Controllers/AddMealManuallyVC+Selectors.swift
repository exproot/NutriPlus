//
//  AddMealManuallyVC+Selectors.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 21.12.2024.
//

import Foundation

// MARK: - Selectors
extension AddMealManuallyViewController {
  @objc func doneButtonTapped() {
    guard
      let name = mealNameTextField.text, !name.isEmpty,
      let selectedTypeIndex = viewModel.selectedMealTypeIndex
    else {
      showAlert(title: "Nutri Plus", message: "Please fill all of the fields.")
      return
    }

    let sliderValues = sliderStackView.extractMacroSliderValues()
    let mealType = viewModel.mealTypes[selectedTypeIndex]
    let meal = viewModel.createMeal(name: name, mealType: mealType, values: sliderValues)

    delegate?.didAddManually(self, meal: meal)
    dismiss(animated: true)
  }

  @objc func cancelButtonTapped() {
    dismiss(animated: true)
  }
}

extension AddMealManuallyViewController {
  func setupActions() {
    modalHeaderView.doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
    modalHeaderView.cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
  }
}
