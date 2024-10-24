//
//  SignUpViewModel.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 21.10.2024.
//

import Foundation
import Combine

protocol SignUpViewModelProtocol {
    var view: SignUpViewControllerProtocol? { get set }
    
    func viewDidLoad()
    func signUpUser(with email: String, and password: String)
}

final class SignUpViewModel {
    private let authService: AuthService
    weak var view: SignUpViewControllerProtocol?
    
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
    
    init(authService: AuthService) {
        self.authService = authService
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

extension SignUpViewModel: SignUpViewModelProtocol {
    func viewDidLoad() {
        view?.setupFields()
        view?.setupButtons()
    }
    
    func signUpUser(with email: String, and password: String) {
        authService.createUser(with: email, and: password) { [weak self] result in
            switch result {
            case .success(let user):
                StoreService.shared.saveUserToFirestore(with: user.uid) { error in
                    if let error = error {
                        print(error)
                    }
                }
                self?.view?.checkAuthenticationViaSceneDelegate()
            case .failure(let error):
                self?.view?.showSignInErrorAlert(message: error.localizedDescription)
            }
        }
    }
}
