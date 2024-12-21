//
//  AuthFooterView.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 21.10.2024.
//

import UIKit

enum AuthType {
  case signIn, signUp
}

final class AuthFooterView: UIView {
  // MARK: - UI Components
  private lazy var footerLabel = CustomLabel(text: "", fontSize: 14, fontWeight: .regular, textColor: .label)

  lazy var footerButton = CustomFooterButton()

  private lazy var footerStack: UIStackView = {
    let sv = UIStackView()
    sv.axis = .horizontal
    sv.spacing = 5
    sv.distribution = .equalSpacing
    sv.alignment = .center
    sv.translatesAutoresizingMaskIntoConstraints = false
    return sv
  }()

  var forgotPassButton: CustomFooterButton?

  init(type: AuthType, frame: CGRect) {
    super.init(frame: frame)
    setupUI(with: type)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - UI Setup
  private func setupUI(with type: AuthType) {
    switch type {
    case .signIn:
      footerLabel.text = "Don't have an account?"
      footerButton.configure(title: "Sign Up")
      forgotPassButton = CustomFooterButton()
      forgotPassButton?.configure(title: "Forgot Password")
    case .signUp:
      footerLabel.text = "Already have an account?"
      footerButton.configure(title: "Sign In")
    }

    translatesAutoresizingMaskIntoConstraints = false
    footerStack.addArrangedSubview(footerLabel)
    footerStack.addArrangedSubview(footerButton)
    addSubview(footerStack)

    footerStack.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    footerStack.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true

    if let forgotPassButton {
      addSubview(forgotPassButton)

      NSLayoutConstraint.activate([
        footerStack.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.7),

        forgotPassButton.topAnchor.constraint(equalTo: footerStack.bottomAnchor),
        forgotPassButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        forgotPassButton.bottomAnchor.constraint(equalTo: self.bottomAnchor)
      ])
    } else {
      footerStack.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    }
  }
}
