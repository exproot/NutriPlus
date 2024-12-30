//
//  SignInViewController.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 21.10.2024.
//

import UIKit

final class SignInViewController: KeyboardHandlingViewController {
  lazy var viewModel = SignInViewModel(authService: AuthService())

  // MARK: - UI Components
  private var headerView = AuthHeaderView(title: "Sign In To Nutri+", subTitle: "Let's personalize your nutrition with AI", frame: .zero)
  lazy var authInputView = AuthInputView(type: .signIn)
  lazy var signInButton = CustomButton(title: "Sign In", backgroundColor: .label, foregroundColor: .systemBackground)
  lazy var googleSignInButton = CustomSignInMethodButton(type: .gmail, frame: .zero)
  lazy var appleSignInButton = CustomSignInMethodButton(type: .apple, frame: .zero)
  lazy var footerView = AuthFooterView(type: .signIn, frame: .zero)

  // MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    setupConstraints()
    setupActions()

    authInputView.emailTextField.delegate = self
    authInputView.passwordTextField.delegate = self
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationItem.hidesBackButton = true
  }
}

// MARK: - UI Setup
extension SignInViewController {
  private func setupUI() {
    view.backgroundColor = .systemBackground
    view.addSubview(headerView)
    view.addSubview(authInputView)
    view.addSubview(signInButton)
    view.addSubview(googleSignInButton)
    view.addSubview(appleSignInButton)
    view.addSubview(footerView)
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      headerView.topAnchor.constraint(equalTo: view.topAnchor),
      headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      headerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.33),

      authInputView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
      authInputView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      authInputView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
      authInputView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25),

      signInButton.topAnchor.constraint(equalTo: authInputView.bottomAnchor, constant: 20),
      signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      signInButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.07),
      signInButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),

      googleSignInButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 20),
      googleSignInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -40),
      googleSignInButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.085),
      googleSignInButton.widthAnchor.constraint(equalTo: googleSignInButton.heightAnchor),

      appleSignInButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 20),
      appleSignInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 40),
      appleSignInButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.085),
      appleSignInButton.widthAnchor.constraint(equalTo: appleSignInButton.heightAnchor),

      footerView.topAnchor.constraint(equalTo: appleSignInButton.bottomAnchor, constant: 20),
      footerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      footerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.12),
      footerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9)
    ])
  }
}
