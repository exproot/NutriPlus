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

    let sliderValues = sliderStackView.extractMacroSliderValues()
    let mealType = viewModel.mealTypes[selectedTypeIndex]
    let meal = viewModel.createMeal(name: name, mealType: mealType, values: sliderValues)

    delegate?.addNewMealController(didAddManually: meal)
    navigationController?.popViewController(animated: true)
  }

  @objc func segmentedControlValueChanged(_ sender: CustomSegmentedControl) {
    if sender.selectedSegmentIndex != 0 {
      let camController = CameraViewController()
      camController.delegate = self
      navigationController?.pushViewController(camController, animated: true)
    }
  }
}

extension AddNewMealViewController {
  func setupActions() {
    headerView.segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
    continueButton.addTarget(self, action: #selector(handleContinueButton), for: .touchUpInside)
  }
}
