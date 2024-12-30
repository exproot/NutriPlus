//
//  FitSelectionVC+Selectors.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 30.12.2024.
//

import UIKit

// MARK: - Selectors
extension FitSelectionViewController {
  @objc private func sliderValueChanged(_ sender: UISlider) {
    let value = round(sender.value)
    sender.value = value

    viewModel.setFitnessLevel(to: Int(value))
  }

  @objc private func continueButtonTapped() {
    assessmentModel.fitLevel = Int(slider.value)

    let vc = GenderSelectionViewController(model: assessmentModel)
    navigationController?.pushViewController(vc, animated: true)
  }
}

extension FitSelectionViewController {
  func setupActions() {
    slider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
    continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
  }
}
