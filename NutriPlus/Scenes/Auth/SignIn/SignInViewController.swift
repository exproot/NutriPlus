//
//  SignInViewController.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 21.10.2024.
//

import UIKit

final class SignInViewController: UIViewController {
    // MARK: - UI Components
    private var headerView = AuthHeaderView(title: "Nutri+'a Giriş Yap.", subTitle: "Yapay zeka desteğiyle hayatını özelleştirelim.", frame: .zero)
    private let emailTextField = CustomTextField(type: .mail, frame: .zero)
    private let passwordTextField = CustomTextField(type: .password, frame: .zero)
    private let signInButton = CustomButton(title: "Sign In",frame: .zero)
    private let googleSignInButton = CustomSignInMethodsButton(type: .gmail, frame: .zero)
    private let appleSignInButton = CustomSignInMethodsButton(type: .apple, frame: .zero)
    private let footerView = AuthFooterView(type: .signIn, frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
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
}
