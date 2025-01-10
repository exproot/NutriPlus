//
//  ChangePasswordViewModel.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 10.01.2025.
//

import Foundation
import Combine

final class ChangePasswordViewModel {
  let authService: AuthServiceProtocol

  init(authService: AuthServiceProtocol) {
    self.authService = authService
    configureSignUpButtonBehaviour()
  }

  // MARK: - Published variables
  @Published var oldPassword = ""
  @Published var newPassword = ""
  @Published var doneButtonEnabled = false

  // MARK: - Publishers
  var newPasswordIsValid: AnyPublisher<Bool, Never> {
    $newPassword
      .map { AuthValidator.isValidPassword(for: $0) }
      .eraseToAnyPublisher()
  }

  // MARK: - Methods
  private func configureSignUpButtonBehaviour() {
    newPasswordIsValid
      .assign(to: &$doneButtonEnabled)
  }

  func changePassword(currentPassword: String, newPassword: String, completion: @escaping (Error?) -> Void) {
    authService.changePassword(currentPassword: currentPassword, newPassword: newPassword) { result in
      switch result {
      case .success():
        completion(nil)
      case .failure(let error):
        completion(error)
      }
    }
  }
}
