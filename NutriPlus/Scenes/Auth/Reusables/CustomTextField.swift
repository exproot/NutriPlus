//
//  CustomTextField.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 21.10.2024.
//

import UIKit

final class CustomTextField: UITextField {
  enum FieldType {
    case mail, password, confirmation
  }

  // MARK: - UI Components
  init(type: FieldType, frame: CGRect) {
    super.init(frame: frame)
    setupUI(type: type)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - UI Setup
  private func setupUI(type: FieldType) {
    layer.masksToBounds = true
    backgroundColor = .systemGray6
    spellCheckingType = .no
    autocapitalizationType = .none
    autocorrectionType = .no
    layer.cornerRadius = 12
    translatesAutoresizingMaskIntoConstraints = false

    switch type {
    case .mail:
      keyboardType = .emailAddress
      placeholder = "Enter email adress"
      addIconWithPadding("envelope.circle.fill", padding: 20, isLeftView: true, isConfirmation: false)
    case .password:
      isSecureTextEntry = true
      keyboardType = .default
      returnKeyType = .done
      placeholder = "Enter password"
      addIconWithPadding("lock.fill", padding: 20, isLeftView: true, isConfirmation: false)
    case .confirmation:
      isSecureTextEntry = true
      keyboardType = .default
      returnKeyType = .done
      placeholder = "Re-Enter Password"
      addIconWithPadding("lock.open", padding: 20, isLeftView: true, isConfirmation: true)
    }
  }
}
