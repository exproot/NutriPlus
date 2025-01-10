//
//  ChangePasswordVC+Selectors.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 10.01.2025.
//

import Foundation

// MARK: - Selectors
extension ChangePasswordViewController {
  @objc func oldPassFieldDidChange(_ sender: CustomTextField) {
    viewModel.oldPassword = sender.text ?? ""
  }

  @objc func newPassFieldDidChange(_ sender: CustomTextField) {
    viewModel.newPassword = sender.text ?? ""
  }

  @objc func handleDoneButton() {
    if let oldPass = oldPasswordTextField.text, let newPass = newPasswordTextField.text {
      viewModel.changePassword(currentPassword: oldPass, newPassword: newPass) { [weak self] error in
        if let error = error {
          self?.showAlert(title: "Error", message: error.localizedDescription)
          return
        }

        self?.showAlert(title: "Success", message: "Password changed successfully.")
      }
    }
  }
}

extension ChangePasswordViewController {
  func setupActions() {
    oldPasswordTextField.addTarget(self, action: #selector(oldPassFieldDidChange(_:)), for: .editingChanged)
    newPasswordTextField.addTarget(self, action: #selector(newPassFieldDidChange(_:)), for: .editingChanged)
    doneButton.addTarget(self, action: #selector(handleDoneButton), for: .touchUpInside)
  }
}
