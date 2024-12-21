//
//  SignUpViewController.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 21.10.2024.
//

import UIKit
import Combine

protocol SignUpViewControllerProtocol: AnyObject {
  func setupFields()
  func setupButtons()
  func showSignInErrorAlert(message: String)
}

final class SignUpViewController: KeyboardHandlingViewController {
  lazy var viewModel = SignUpViewModel(authService: AuthService())
  var cancellables: Set<AnyCancellable> = []
  var lockImageCancellable: AnyCancellable?

  // MARK: - UI Components
  private lazy var headerView = AuthHeaderView(title: "Hesap Oluştur", subTitle: "Ücretsiz olarak hesabını oluştur.", frame: .zero)
  private lazy var signUpButton = CustomButton(title: "Sign Up", frame: .zero)
  private lazy var authInputView = AuthInputView(type: .signUp)
  private lazy var footerView = AuthFooterView(type: .signUp, frame: .zero)

  // MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    viewModel.view = self
    viewModel.viewDidLoad()

    guard let confirmationField = authInputView.passwordConfirmationTextField else { return }
    authInputView.emailTextField.delegate = self
    authInputView.passwordTextField.delegate = self
    confirmationField.delegate = self

    lockImageCancellable =  viewModel.$confirmImageString
      .sink { imageString in
        confirmationField.addIconWithPadding(imageString, padding: 20, isLeftView: true, isConfirmation: true)
      }

    viewModel.$signUpButtonEnabled
      .assign(to: \.isEnabled, on: signUpButton)
      .store(in: &cancellables)
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
    view.addSubview(signUpButton)
    view.addSubview(footerView)

    NSLayoutConstraint.activate([
      headerView.topAnchor.constraint(equalTo: view.topAnchor),
      headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      headerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.33),

      authInputView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
      authInputView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      authInputView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
      authInputView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.37),

      signUpButton.topAnchor.constraint(equalTo: authInputView.bottomAnchor, constant: 20),
      signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      signUpButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.07),
      signUpButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),

      footerView.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 20),
      footerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      footerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.12),
      footerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9)
    ])
  }

  // MARK: - Selectors
  @objc private func signUpButtonTapped() {
    if let email = authInputView.emailTextField.text, let password = authInputView.passwordTextField.text {
      viewModel.signUpUser(with: email, and: password)
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

extension SignUpViewController: SignUpViewControllerProtocol {
  func showSignInErrorAlert(message: String) {
    let alert = UIAlertController(title: "Sign In Failed", message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Ok", style: .default))
    self.present(alert, animated: true)
  }

  func setupButtons() {
    signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
    footerView.footerButton.addTarget(self, action: #selector(signInPressed), for: .touchUpInside)
  }

  func setupFields() {
    guard let confirmationField = authInputView.passwordConfirmationTextField else { return }
    authInputView.emailTextField.addTarget(self, action: #selector(emailFieldDidChange), for: .editingChanged)
    authInputView.passwordTextField.addTarget(self, action: #selector(passwordFieldDidChange), for: .editingChanged)
    confirmationField.addTarget(self, action: #selector(confirmationFieldDidChange), for: .editingChanged)
  }
}
