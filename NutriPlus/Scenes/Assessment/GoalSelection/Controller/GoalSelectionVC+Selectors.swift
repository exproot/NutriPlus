//
//  GoalSelectionVC+Selectors.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 30.12.2024.
//

import Foundation

// MARK: - Selectors
extension GoalSelectionViewController {
  @objc func continueButtonTapped() {
    guard let selectedGoal = viewModel.selectedGoal else { return }
    assessmentModel.goal = selectedGoal
      .filter { $0.isASCII }
      .trimmingCharacters(in: .whitespacesAndNewlines)

    viewModel.addAssessment(assessment: assessmentModel) { [weak self] in
      self?.checkAuthViaSceneDelegate()
    }
  }
}

extension GoalSelectionViewController {
  func setupActions() {
    continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
  }
}
