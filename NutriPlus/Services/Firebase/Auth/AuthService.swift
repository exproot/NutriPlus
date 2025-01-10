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
  func changePassword(currentPassword: String, newPassword: String, completion: @escaping (Result<Void, Error>) -> Void) {
    guard let user = Auth.auth().currentUser, let email = user.email else {
      fatalError("No user is signed in.")
    }

    let credential = EmailAuthProvider.credential(withEmail: email, password: currentPassword)
    user.reauthenticate(with: credential) { _, error in
      if let error = error {
        completion(.failure(error))
        return
      }

      user.updatePassword(to: newPassword) { error in
        if let error = error {
          completion(.failure(error))
        } else {
          completion(.success(()))
        }
      }
    }
  }

  func getSignedUser() -> NutriUser? {
    guard let currentUser = Auth.auth().currentUser else { return nil }

    return NutriUser(
      email: currentUser.email ?? ""
    )
  }

  func getCurrentUser() -> User? {
    Auth.auth().currentUser
  }

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
