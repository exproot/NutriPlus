//
//  SignInViewController.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 21.10.2024.
//

import UIKit

protocol SignInViewControllerProtocol: AnyObject {
  func setupButtons()
  func showSignInErrorAlert(message: String)
}

final class SignInViewController: KeyboardHandlingViewController {
  lazy var viewModel = SignInViewModel(authService: AuthService())

  // MARK: - UI Components
  private var headerView = AuthHeaderView(title: "Sign In To Nutri+", subTitle: "Let's personalize your nutrition with AI", frame: .zero)
  private lazy var authInputView = AuthInputView(type: .signIn)
  private lazy var signInButton = CustomButton(title: "Sign In", frame: .zero)
  private lazy var googleSignInButton = CustomSignInMethodsButton(type: .gmail, frame: .zero)
  private lazy var  appleSignInButton = CustomSignInMethodsButton(type: .apple, frame: .zero)
  private lazy var footerView = AuthFooterView(type: .signIn, frame: .zero)

  // MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    viewModel.view = self
    viewModel.viewDidLoad()

    authInputView.emailTextField.delegate = self
    authInputView.passwordTextField.delegate = self
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationItem.hidesBackButton = true
  }

  // MARK: - UI Setup
  private func setupUI() {
    view.backgroundColor = .systemBackground
    view.addSubview(headerView)
    view.addSubview(authInputView)
    view.addSubview(signInButton)
    view.addSubview(googleSignInButton)
    view.addSubview(appleSignInButton)
    view.addSubview(footerView)

    NSLayoutConstraint.activate([
      headerView.topAnchor.constraint(equalTo: view.topAnchor),
      headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      headerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.33),

      authInputView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
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

  // MARK: - Selectors
  @objc private func signInButtonTapped() {
    if let email = authInputView.emailTextField.text, let password = authInputView.passwordTextField.text {
      viewModel.signInUser(with: email, and: password)
    }
  }

  @objc private func forgotPassPressed() {
    let vc = ResetPasswordViewController()
    if let sheet = vc.sheetPresentationController {
      sheet.detents = [.medium()]
    }

    navigationController?.present(vc, animated: true)
  }

  @objc private func signUpPressed() {
    let vc = SignUpViewController()
    navigationController?.pushViewController(vc, animated: true)
  }
}

extension SignInViewController: SignInViewControllerProtocol {
  func showSignInErrorAlert(message: String) {
    let alert = UIAlertController(title: "Sign In Failed", message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Ok", style: .default))
    self.present(alert, animated: true)
  }

  func setupButtons() {
    signInButton.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
    footerView.footerButton.addTarget(self, action: #selector(signUpPressed), for: .touchUpInside)
    guard let forgotPassButton = footerView.forgotPassButton else { return }
    forgotPassButton.addTarget(self, action: #selector(forgotPassPressed), for: .touchUpInside)
  }
}
