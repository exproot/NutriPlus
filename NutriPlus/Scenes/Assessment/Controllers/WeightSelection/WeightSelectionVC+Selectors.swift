//
//  WeightSelectionVC+Selectors.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 30.12.2024.
//

import UIKit

// MARK: - Selectors
extension WeightSelectionViewController {
  @objc func weightSliderChanged(_ sender: UISlider) {
    let step: Float = 1.0
    let roundedValue = round(sender.value / step) * step
    sender.value = roundedValue
    viewModel.updateWeight(sender.value)
  }

  @objc func unitChanged() {
    let selectedUnit: WeightUnit = bodyMeasurementView.unitSelector.selectedSegmentIndex == 0 ? .kg : .lbs
    viewModel.updateUnit(selectedUnit)
  }

  @objc func continueButtonTapped() {
    assessmentModel.weight = Int(bodyMeasurementView.valueSlider.value)

    let vc = HeightSelectionViewController(model: assessmentModel)
    navigationController?.pushViewController(vc, animated: true)
  }
}

extension WeightSelectionViewController {
  func setupActions() {
    bodyMeasurementView.valueSlider.addTarget(self, action: #selector(weightSliderChanged(_:)), for: .valueChanged)
    bodyMeasurementView.unitSelector.addTarget(self, action: #selector(unitChanged), for: .valueChanged)
    bodyMeasurementView.continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
  }
}
