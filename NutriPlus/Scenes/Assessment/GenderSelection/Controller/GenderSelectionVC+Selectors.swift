//
//  GenderSelectionVC+Selectors.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 30.12.2024.
//

import UIKit

// MARK: - Selectors
extension GenderSelectionViewController {
  @objc func didTapGenderView(_ sender: UITapGestureRecognizer) {
    if sender.view == maleSelectionView {
      viewModel.selectGender(.male)
    } else if sender.view == femaleSelectionView {
      viewModel.selectGender(.female)
    }
  }

  @objc func continueButtonTapped() {
    assessmentModel.gender = viewModel.selectedGender == .male

    let vc = GoalSelectionViewController(model: assessmentModel)
    navigationController?.pushViewController(vc, animated: true)
  }
}

extension GenderSelectionViewController {
  func setupActions() {
    let maleTapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapGenderView))
    let femaleTapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapGenderView))
    
    continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
    maleSelectionView.addGestureRecognizer(maleTapGesture)
    femaleSelectionView.addGestureRecognizer(femaleTapGesture)
  }
}
