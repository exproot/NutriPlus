//
//  KeyboardHandlingViewController.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 21.12.2024.
//

import UIKit

class KeyboardHandlingViewController: UIViewController {
  private var activeTextField: UITextField?

  override func viewDidLoad() {
    super.viewDidLoad()

    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboardIfNoResponder))
    tapGesture.cancelsTouchesInView = false
    view.addGestureRecognizer(tapGesture)
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
}

// MARK: - UITextFieldDelegate
extension KeyboardHandlingViewController: UITextFieldDelegate {
  func textFieldDidBeginEditing(_ textField: UITextField) {
    activeTextField = textField
  }

  func textFieldDidEndEditing(_ textField: UITextField) {
    activeTextField = nil
  }

  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
}

// MARK: - Selectors
extension KeyboardHandlingViewController {
  @objc private func keyboardWillHide(notification: NSNotification) {
    view.frame.origin.y = 0
  }

  @objc private func keyboardWillShow(notification: NSNotification) {
    guard
      let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
      let activeTextField = activeTextField
    else {
      return
    }

    let keyboardTop = view.frame.height - keyboardFrame.height
    let bottomOfTextField = activeTextField.convert(activeTextField.bounds, to: view).maxY

    if bottomOfTextField > keyboardTop {
      let offset = bottomOfTextField - keyboardTop + 20
      view.frame.origin.y = -offset
    }
  }

  @objc private func dismissKeyboardIfNoResponder(_ gesture: UITapGestureRecognizer) {
    if activeTextField != nil {
      view.endEditing(true)
    }
  }
}
