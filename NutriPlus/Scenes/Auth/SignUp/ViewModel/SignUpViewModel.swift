//
//  SignUpViewModel.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 21.10.2024.
//

import Foundation
import Combine
import FirebaseFirestore

final class SignUpViewModel {
  let authService: AuthService
  let firestoreService: FirestoreDatabaseService

  init(authService: AuthService, firestoreService: FirestoreDatabaseService) {
    self.authService = authService
    self.firestoreService = firestoreService
    setupPipeline()
  }

  // MARK: - Published variables
  @Published
  var email = ""

  @Published
  var password = ""

  @Published
  var confirmPass = ""

  //UI States
  @Published
  var signUpButtonEnabled = false

  @Published
  var confirmImageString = "lock.open.fill"

// MARK: - Methods
  func signUpUser(with email: String, and password: String, completion: @escaping (Error?) -> Void) {
    authService.signUp(with: email, and: password) { [weak self] result in
      switch result {
      case .success(let user):
        let userRef = Firestore.firestore().collection("users").document(user.uid)
        let data = ["assessment_done" : false]

        self?.firestoreService.setData(for: userRef, data: data) { error in
          if let error = error {
            completion(error)
            return
          }
          completion(nil)
        }
      case .failure(let error):
        completion(error)
      }
    }
  }

  private func setupPipeline() {
    configurePasswordBehaviour()
    configureSignUpButtonBehaviour()
  }

  private func configurePasswordBehaviour() {
    passValidAndConfirmed
      .map { $0 ? "lock.fill": "lock.open.fill" }
      .assign(to: &$confirmImageString)
  }

  private func configureSignUpButtonBehaviour() {
    formIsValid
      .assign(to: &$signUpButtonEnabled)
  }

// MARK: - Publishers
  var formattedEmailAdress: AnyPublisher<String, Never> {
    $email
      .map { $0.lowercased() }
      .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
      .eraseToAnyPublisher()
  }

  var emailIsValid: AnyPublisher<Bool, Never> {
    formattedEmailAdress
      .map { AuthValidator.isValidEmail(for: $0) }
      .eraseToAnyPublisher()
  }

  var passIsValid: AnyPublisher<Bool, Never> {
    $password
      .map { AuthValidator.isValidPassword(for: $0) }
      .eraseToAnyPublisher()
  }

  var passesMatched: AnyPublisher<Bool, Never> {
    $password
      .combineLatest($confirmPass)
      .map { pass, confirm in
        pass == confirm
      }
      .eraseToAnyPublisher()
  }

  var passValidAndConfirmed: AnyPublisher<Bool, Never> {
    passIsValid
      .combineLatest(passesMatched)
      .map { valid, confirmed in
        valid && confirmed
      }
      .eraseToAnyPublisher()
  }

  var formIsValid: AnyPublisher<Bool, Never> {
    Publishers.CombineLatest(emailIsValid, passValidAndConfirmed)
      .map { $0.0 && $0.1 }
      .eraseToAnyPublisher()
  }
}
