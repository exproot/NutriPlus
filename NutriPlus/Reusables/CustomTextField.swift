//
//  CustomTextField.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 21.10.2024.
//

import UIKit

final class CustomTextField: UITextField {
  enum AuthType {
    case mail, password, confirmation
  }

  init(placeholder: String, borderStyle: UITextField.BorderStyle, returnKeyType: UIReturnKeyType, spellCheckingType: UITextSpellCheckingType, autoCorrectionType: UITextAutocorrectionType) {
    super.init(frame: .zero)
    self.placeholder = placeholder
    self.borderStyle = borderStyle
    self.returnKeyType = returnKeyType
    self.spellCheckingType = spellCheckingType
    self.autocorrectionType = autoCorrectionType
    self.clipsToBounds = true
    translatesAutoresizingMaskIntoConstraints = false
  }

  /// Custom Textfield
  /// - Parameters:
  ///   - placeholder: Placeholder string.
  ///   - fontSize: TextField's font size.
  ///   - fontWeight: TextField's font weight.
  ///   - cornerRadius: TextField's corner radius.
  ///   - textAlignment: TextField's text alignment defaults to center.
  ///   - backgroundColor: TextField's background color defaults to systemGray6.
  init(placeholder: String, fontSize: CGFloat, fontWeight: UIFont.Weight, cornerRadius: CGFloat, textAlignment: NSTextAlignment = .center, backgroundColor: UIColor = .systemGray6) {
    super.init(frame: .zero)
    self.placeholder = placeholder
    self.font = .systemFont(ofSize: fontSize, weight: fontWeight)
    self.layer.cornerRadius = cornerRadius
    self.layer.masksToBounds = true
    self.textAlignment = textAlignment
    self.backgroundColor = backgroundColor
    translatesAutoresizingMaskIntoConstraints = false
  }

  /// TextField for auth operations.
  /// - Parameters:
  ///   - type: E-Mail, password or password confirmation.
  init(type: AuthType) {
    super.init(frame: .zero)
    configureAuthField(type: type)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - UI Setup
  private func configureAuthField(type: AuthType) {
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
