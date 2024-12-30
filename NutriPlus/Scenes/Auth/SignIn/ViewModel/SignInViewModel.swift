//
//  SignInViewModel.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 23.10.2024.
//

import Foundation

final class SignInViewModel {
  let authService: AuthService

  init(authService: AuthService) {
    self.authService = authService
  }

  func signInUser(with email: String, and password: String, completion: @escaping (Error?) -> Void) {
    authService.signIn(with: email, and: password) { result in
      switch result {
      case .success:
        print("User signed in succesfully.")
        completion(nil)
      case .failure(let error):
        completion(error)
      }
    }
  }
}
