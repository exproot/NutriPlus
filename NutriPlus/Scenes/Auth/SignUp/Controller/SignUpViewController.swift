//
//  SignUpViewController.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 21.10.2024.
//

import UIKit
import Combine

final class SignUpViewController: KeyboardHandlingViewController {
  lazy var viewModel = SignUpViewModel(authService: AuthService(), firestoreService: FirestoreDatabaseService())
  var cancellables: Set<AnyCancellable> = []
  var lockImageCancellable: AnyCancellable?

  // MARK: - UI Components
  private lazy var headerView = AuthHeaderView(title: "Sign Up To Nutri+", subTitle: "Quickly create your account to experience Nutri+.", frame: .zero)
  lazy var signUpButton = CustomButton(title: "Sign Up", backgroundColor: .label, foregroundColor: .systemBackground)
  lazy var authInputView = AuthInputView(type: .signUp)
  lazy var footerView = AuthFooterView(type: .signUp, frame: .zero)

  // MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    setupConstraints()
    setupActions()
    setupBindings()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationItem.hidesBackButton = true
  }

  // MARK: - Methods
  private func setupBindings() {
    guard let confirmationField = authInputView.passwordConfirmationTextField else { return }
    confirmationField.delegate = self
    authInputView.emailTextField.delegate = self
    authInputView.passwordTextField.delegate = self

    lockImageCancellable = viewModel.$confirmImageString
      .removeDuplicates()
      .sink { imageString in
        confirmationField.addIconWithPadding(imageString, padding: 20, isLeftView: true, isConfirmation: true)
      }

    viewModel.$signUpButtonEnabled
      .assign(to: \.isEnabled, on: signUpButton)
      .store(in: &cancellables)
  }
}

// MARK: - UI Setup
extension SignUpViewController {
  private func setupUI() {
    view.backgroundColor = .systemBackground
    view.addSubview(headerView)
    view.addSubview(authInputView)
    view.addSubview(signUpButton)
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
}
