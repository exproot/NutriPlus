//
//  SignUpVC+Selectors.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 30.12.2024.
//

import Foundation

// MARK: - Selectors
extension SignUpViewController {
  @objc private func signUpButtonTapped() {
    if let email = authInputView.emailTextField.text, let password = authInputView.passwordTextField.text {
      viewModel.signUpUser(with: email, and: password) { [weak self] error in
        if let error {
          self?.showAlert(title: "Sign Up Failed", message: error.localizedDescription)
        }
      }
    }
  }

  @objc private func emailFieldDidChange() {
    viewModel.email = authInputView.emailTextField.text ?? ""
  }

  @objc private func passwordFieldDidChange() {
    viewModel.password = authInputView.passwordTextField.text ?? ""
  }

  @objc private func confirmationFieldDidChange() {
    guard let confirmationField = authInputView.passwordConfirmationTextField else { return }
    viewModel.confirmPass = confirmationField.text ?? ""
  }

  @objc private func signInPressed() {
    navigationController?.popToRootViewController(animated: true)
  }
}

extension SignUpViewController {
  func setupActions() {
    guard let confirmationField = authInputView.passwordConfirmationTextField else { return }
    signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
    footerView.footerButton.addTarget(self, action: #selector(signInPressed), for: .touchUpInside)
    authInputView.emailTextField.addTarget(self, action: #selector(emailFieldDidChange), for: .editingChanged)
    authInputView.passwordTextField.addTarget(self, action: #selector(passwordFieldDidChange), for: .editingChanged)
    confirmationField.addTarget(self, action: #selector(confirmationFieldDidChange), for: .editingChanged)
  }
}
