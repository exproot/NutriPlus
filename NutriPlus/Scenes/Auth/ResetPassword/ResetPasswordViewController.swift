//
//  ResetPasswordViewController.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 21.10.2024.
//

import UIKit

final class ResetPasswordViewController: UIViewController {
  // MARK: - UI Components
  private lazy var titleLabel = CustomLabel(text: "Reset Password", fontSize: 28, fontWeight: .bold, textColor: .label)
  private lazy var subtitleLabel = CustomLabel(text: "Select what method you'd like to reset.", fontSize: 18, fontWeight: .regular, textColor: .secondaryLabel)
  private lazy var resetPassButton = CustomButton(imageString: "envelope.fill", title: "Reset via Email", subtitle: "Seamlessly reset your password via email adress.")

  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    setupConstraints()
  }

  // MARK: - UI Setup
  private func setupUI() {
    view.backgroundColor = .systemBackground
    view.addSubview(titleLabel)
    view.addSubview(subtitleLabel)
    view.addSubview(resetPassButton)
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
      titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

      subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
      subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

      resetPassButton.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 40),
      resetPassButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      resetPassButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9)
    ])
  }
}
