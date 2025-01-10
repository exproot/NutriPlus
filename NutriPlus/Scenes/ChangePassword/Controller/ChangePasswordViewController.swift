//
//  ChangePasswordViewController.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 10.01.2025.
//

import UIKit
import Combine

final class ChangePasswordViewController: KeyboardHandlingViewController {
  lazy var viewModel = ChangePasswordViewModel(authService: AuthService())
  private var cancellables: Set<AnyCancellable> = []

  // MARK: - UI Components
  private lazy var oldPasswordTitle = CustomLabel(text: "Old Password", fontSize: 14, fontWeight: .semibold, textColor: .label)
  private lazy var newPasswordTitle = CustomLabel(text: "New Password", fontSize: 14, fontWeight: .semibold, textColor: .label)
  lazy var oldPasswordTextField = CustomTextField(type: .password)
  lazy var newPasswordTextField = CustomTextField(type: .password)
  lazy var doneButton = CustomButton(title: "Done", backgroundColor: .label, foregroundColor: .systemBackground)

  private lazy var stackView: UIStackView = {
    let customStack = UIStackView(arrangedSubviews: [
      oldPasswordTitle,
      oldPasswordTextField,
      newPasswordTitle,
      newPasswordTextField
    ])
    customStack.axis = .vertical
    customStack.distribution = .fillEqually
    customStack.translatesAutoresizingMaskIntoConstraints = false
    return customStack
  }()

  // MARK: - Controller Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    setupActions()
    configureTextFields()

    viewModel.$doneButtonEnabled
      .assign(to: \.isEnabled, on: doneButton)
      .store(in: &cancellables)
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.navigationBar.isHidden = false
    navigationController?.navigationBar.tintColor = .label
    tabBarController?.tabBar.isHidden = true
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    navigationController?.navigationBar.isHidden = true
    tabBarController?.tabBar.isHidden = false
  }

  // MARK: - UI Setup
  private func configureTextFields() {
    oldPasswordTextField.placeholder = "Old password"
    newPasswordTextField.placeholder = "New password"
    oldPasswordTextField.delegate = self
    newPasswordTextField.delegate = self
  }

  private func setupUI() {
    title = "Change Password"
    view.backgroundColor = .systemBackground
    view.addSubview(stackView)
    view.addSubview(doneButton)

    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
      stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      stackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
      stackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.32),

      doneButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
      doneButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      doneButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.07),
      doneButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9)
    ])
  }
}
