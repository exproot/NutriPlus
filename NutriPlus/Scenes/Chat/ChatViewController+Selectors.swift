//
//  ChatViewController+Selectors.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 24.12.2024.
//

import UIKit

// MARK: - Selectors
extension ChatViewController {
  @objc func sendMessage() {
    guard let messageText = textField.text, !messageText.isEmpty else { return }
    textField.text = ""
    viewModel.sendMessage(messageText)
  }

  override func keyboardWillShow(notification: NSNotification) {
    guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
    let keyboardHeight = keyboardFrame.height
    
    inputContainerBottomConstraint.constant = -keyboardHeight
    view.layoutIfNeeded()
    scrollToBottom()
  }

  override func keyboardWillHide(notification: NSNotification) {
    inputContainerBottomConstraint.constant = 0
    view.layoutIfNeeded()
  }

  override func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    guard let messageText = textField.text, !messageText.isEmpty else { return false }
    textField.text = ""
    viewModel.sendMessage(messageText)
    textField.resignFirstResponder()
    return true
  }
}
