//
//  AgeSelectionVC+Selectors.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 30.12.2024.
//

import Foundation

// MARK: - Selectors
extension AgeSelectionViewController {
  @objc func continueButtonTapped() {
    assessmentModel.age = viewModel.selectedAge

    let vc = WeightSelectionViewController(model: assessmentModel)
    navigationController?.pushViewController(vc, animated: true)
  }
}
