//
//  SignUpViewModel.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 21.10.2024.
//

import Foundation
import Combine

final class SignUpViewModel {
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
    
    init() {
        setupPipeline()
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
