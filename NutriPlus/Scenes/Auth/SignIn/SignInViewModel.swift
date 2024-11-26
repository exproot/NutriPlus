//
//  SignInViewModel.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 23.10.2024.
//

import Foundation

protocol SignInViewModelProtocol {
    var view: SignInViewControllerProtocol? { get set }
    
    func viewDidLoad()
    func signInUser(with email: String, and password: String)
}

final class SignInViewModel {
    let authService: AuthService
    weak var view: SignInViewControllerProtocol?
    
    init(authService: AuthService) {
        self.authService = authService
    }
}

extension SignInViewModel: SignInViewModelProtocol {
    func signInUser(with email: String, and password: String) {
        authService.signIn(with: email, and: password) { [weak self] result in
            switch result {
            case .success(_):
                print("User signed in succesfully.")
            case .failure(let error):
                self?.view?.showSignInErrorAlert(message: error.localizedDescription)
            }
        }
    }
    
    func viewDidLoad() {
        view?.setupButtons()
    }
}
