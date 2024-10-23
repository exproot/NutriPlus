//
//  SignInViewController.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 21.10.2024.
//

import UIKit

protocol SignInViewControllerProtocol: AnyObject {
    func setupButtons()
    func showSignInErrorAlert(message: String)
    func checkAuthenticationViaSceneDelegate()
}

final class SignInViewController: UIViewController {
    lazy var viewModel = SignInViewModel(authService: AuthService())
    
    // MARK: - UI Components
    private var headerView = AuthHeaderView(title: "Nutri+'a Giriş Yap.", subTitle: "Yapay zeka desteğiyle hayatını özelleştirelim.", frame: .zero)
    private let emailTextField = CustomTextField(type: .mail, frame: .zero)
    private let passwordTextField = CustomTextField(type: .password, frame: .zero)
    private let signInButton = CustomButton(title: "Sign In",frame: .zero)
    private let googleSignInButton = CustomSignInMethodsButton(type: .gmail, frame: .zero)
    private let appleSignInButton = CustomSignInMethodsButton(type: .apple, frame: .zero)
    private let footerView = AuthFooterView(type: .signIn, frame: .zero)
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.view = self
        viewModel.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(headerView)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(signInButton)
        view.addSubview(googleSignInButton)
        view.addSubview(appleSignInButton)
        view.addSubview(footerView)
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 250),
            
            emailTextField.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 40),
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: 55),
            emailTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 40),
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 55),
            passwordTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            
            signInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signInButton.heightAnchor.constraint(equalToConstant: 55),
            signInButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            
            googleSignInButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 40),
            googleSignInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -40),
            googleSignInButton.heightAnchor.constraint(equalToConstant: 65),
            googleSignInButton.widthAnchor.constraint(equalToConstant: 65),
            
            appleSignInButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 40),
            appleSignInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 40),
            appleSignInButton.heightAnchor.constraint(equalToConstant: 65),
            appleSignInButton.widthAnchor.constraint(equalToConstant: 65),
            
            footerView.topAnchor.constraint(equalTo: appleSignInButton.bottomAnchor, constant: 20),
            footerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            footerView.heightAnchor.constraint(equalToConstant: 100),
            footerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9)
            
        ])
    }
    
    // MARK: - Selectors
    @objc private func signInButtonTapped() {
        if let email = emailTextField.text, let password = passwordTextField.text {
            viewModel.signInUser(with: email, and: password)
        }
    }
    
    @objc private func forgotPassPressed() {
        let vc = ResetPasswordViewController()
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.medium()]
        }
        
        navigationController?.present(vc, animated: true)
    }
    
    @objc private func signUpPressed() {
        let vc = SignUpViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension SignInViewController: SignInViewControllerProtocol {
    func checkAuthenticationViaSceneDelegate() {
        if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
            sceneDelegate.checkAuthentication()
        }
    }
    
    func showSignInErrorAlert(message: String) {
        let alert = UIAlertController(title: "Sign In Failed", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alert, animated: true)
    }
    
    func setupButtons() {
        signInButton.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
        footerView.footerButton.addTarget(self, action: #selector(signUpPressed), for: .touchUpInside)
        footerView.forgotPassButton.addTarget(self, action: #selector(forgotPassPressed), for: .touchUpInside)
    }
}
