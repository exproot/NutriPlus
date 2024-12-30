//
//  AuthService.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 23.10.2024.
//

import Foundation
import FirebaseAuth

enum AuthServiceError: Error {
  case firebaseError(Error)
  case unknownError
  case invalidCredentials
}

final class AuthService: AuthServiceProtocol {
  func signOut(completion: @escaping (Error?) -> Void) {
    do {
      try Auth.auth().signOut()
      completion(nil)
    } catch {
      completion(error)
    }
  }

  func signIn(with email: String, and password: String, completion: @escaping (Result<User, Error>) -> Void) {
    Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
      self?.handleAuthResult(result, error, completion: completion)
    }
  }

  func signUp(with email: String, and password: String, completion: @escaping (Result<User, Error>) -> Void) {
    Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
      self?.handleAuthResult(result, error, completion: completion)
    }
  }

  private func handleAuthResult(_ result: AuthDataResult?, _ error: Error?, completion: (Result<User, Error>) -> Void) {
    if let error = error {
      completion(.failure(AuthServiceError.firebaseError(error)))
    } else if let user = result?.user {
      completion(.success(user))
    } else {
      completion(.failure(AuthServiceError.unknownError))
    }
  }
}
