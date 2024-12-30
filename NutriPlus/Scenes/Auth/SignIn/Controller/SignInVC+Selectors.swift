//
//  SignInVC+Selectors.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 30.12.2024.
//

import Foundation

// MARK: - Selectors
extension SignInViewController {
  @objc func signInButtonTapped() {
    if let email = authInputView.emailTextField.text, let password = authInputView.passwordTextField.text {
      viewModel.signInUser(with: email, and: password) { [weak self] error in
        if let error {
          self?.showAlert(title: "Sign In Failed", message: error.localizedDescription)
        }
      }
    }
  }

  @objc func forgotPassPressed() {
    let vc = ResetPasswordViewController()
    if let sheet = vc.sheetPresentationController {
      sheet.detents = [.medium()]
    }

    navigationController?.present(vc, animated: true)
  }

  @objc func signUpPressed() {
    let vc = SignUpViewController()
    navigationController?.pushViewController(vc, animated: true)
  }
}

extension SignInViewController {
  func setupActions() {
    signInButton.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
    footerView.footerButton.addTarget(self, action: #selector(signUpPressed), for: .touchUpInside)
    guard let forgotPassButton = footerView.forgotPassButton else { return }
    forgotPassButton.addTarget(self, action: #selector(forgotPassPressed), for: .touchUpInside)
  }
}
