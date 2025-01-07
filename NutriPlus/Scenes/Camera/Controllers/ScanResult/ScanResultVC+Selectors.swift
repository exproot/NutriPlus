//
//  ScanResultVC+Selectors.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 30.12.2024.
//

import Foundation

// MARK: - Selectors
extension ScanResultViewController {
  @objc func handleDoneButton() {
    dismiss(animated: true) { [weak self] in
      guard let self = self else { return }

      if let meal = viewModel.meal {
        self.delegate?.scanResultController(self, didConfirmMeal: meal)
      }
    }
  }

  @objc func handleCancelButton() {
    dismiss(animated: true) { [weak self] in
      guard let self = self else { return }

      self.delegate?.scanResultControllerDidCancel(self)
    }
  }
}

extension ScanResultViewController {
  func setupActions() {
    modalHeaderView.cancelButton.addTarget(self, action: #selector(handleCancelButton), for: .touchUpInside)
    modalHeaderView.doneButton.addTarget(self, action: #selector(handleDoneButton), for: .touchUpInside)
  }
}
