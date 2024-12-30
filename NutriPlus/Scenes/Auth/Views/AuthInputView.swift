//
//  AuthInputView.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 21.12.2024.
//

import UIKit

final class AuthInputView: UIView {
  lazy var emailTitle = CustomLabel(text: "Email Adress", fontSize: 14, fontWeight: .semibold, textColor: .label)
  lazy var emailTextField = CustomTextField(type: .mail)
  lazy var passwordTitle = CustomLabel(text: "Password", fontSize: 14, fontWeight: .semibold, textColor: .label)
  lazy var passwordTextField = CustomTextField(type: .password)

  var passwordConfirmationTitle: CustomLabel?
  var passwordConfirmationTextField: CustomTextField?

  private lazy var stackView: UIStackView = {
    let customStack = UIStackView()
    customStack.axis = .vertical
    customStack.distribution = .fillEqually
    customStack.translatesAutoresizingMaskIntoConstraints = false
    return customStack
  }()

  init(type: AuthType) {
    if type == .signUp {
      passwordConfirmationTitle = CustomLabel(text: "Confirm Password", fontSize: 14, fontWeight: .semibold, textColor: .label)
      passwordConfirmationTextField = CustomTextField(type: .confirmation)
    }
    super.init(frame: .zero)
    setupUI()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - UI Setup
  private func setupUI() {
    translatesAutoresizingMaskIntoConstraints = false
    stackView.addArrangedSubview(emailTitle)
    stackView.addArrangedSubview(emailTextField)
    stackView.addArrangedSubview(passwordTitle)
    stackView.addArrangedSubview(passwordTextField)

    if let confirmationTitle = passwordConfirmationTitle, let confirmationField = passwordConfirmationTextField {
      stackView.addArrangedSubview(confirmationTitle)
      stackView.addArrangedSubview(confirmationField)
    }

    addSubview(stackView)

    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: self.topAnchor),
      stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
    ])
  }
}
