//
//  HeightSelectionVC+Selectors.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 30.12.2024.
//

import UIKit

// MARK: - Selectors
extension HeightSelectionViewController {
  @objc func sliderValueChanged(_ sender: UISlider) {
    let step: Float = 1.0
    let roundedValue = round(sender.value / step) * step
    sender.value = roundedValue
    viewModel.updateHeight(sender.value)
  }

  @objc func unitChanged() {
    let selectedUnit: HeightUnit = bodyMeasurementView.unitSelector.selectedSegmentIndex == 0 ? .centimeter : .feet
    viewModel.updateUnit(selectedUnit)
  }

  @objc func continueButtonTapped() {
    assessmentModel.height = Int(bodyMeasurementView.valueSlider.value)

    let vc = FitSelectionViewController(model: assessmentModel)
    navigationController?.pushViewController(vc, animated: true)
  }
}

extension HeightSelectionViewController {
  func setupActions() {
    bodyMeasurementView.continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
    bodyMeasurementView.valueSlider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
    bodyMeasurementView.unitSelector.addTarget(self, action: #selector(unitChanged), for: .valueChanged)
  }
}
