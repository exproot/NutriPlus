//
//  SignUpViewController.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 21.10.2024.
//

import UIKit
import Combine

protocol SignUpViewControllerProtocol: AnyObject {
    func setupFields()
    func setupButtons()
    func showSignInErrorAlert(message: String)
}

final class SignUpViewController: UIViewController {
    lazy var viewModel = SignUpViewModel(authService: AuthService())
    var cancellables: Set<AnyCancellable> = []
    var lockImageCancellable: AnyCancellable?
    
    // MARK: - UI Components
    private var headerView = AuthHeaderView(title: "Hesap Oluştur", subTitle: "Ücretsiz olarak hesabını oluştur.", frame: .zero)
    private let emailTextField = CustomTextField(type: .mail, frame: .zero)
    private let passwordTextField = CustomTextField(type: .password, frame: .zero)
    private let confirmationTextField = CustomTextField(type: .confirmation, frame: .zero)
    private let signUpButton = CustomButton(title: "Sign Up", frame: .zero)
    private let footerView = AuthFooterView(type: .signUp, frame: .zero)
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.view = self
        viewModel.viewDidLoad()
        
        lockImageCancellable =  viewModel.$confirmImageString
            .sink { [weak self] imageString in
                self?.confirmationTextField.addIconWithPadding(imageString, padding: 20, isLeftView: true, isConfirmation: true)
            }
        
        viewModel.$signUpButtonEnabled
            .assign(to: \.isEnabled, on: signUpButton)
            .store(in: &cancellables)
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
        view.addSubview(confirmationTextField)
        view.addSubview(signUpButton)
        view.addSubview(footerView)
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 250),
            
            emailTextField.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 40),
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            emailTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 40),
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            passwordTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            
            confirmationTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 40),
            confirmationTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            confirmationTextField.heightAnchor.constraint(equalToConstant: 50),
            confirmationTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            
            signUpButton.topAnchor.constraint(equalTo: confirmationTextField.bottomAnchor, constant: 20),
            signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpButton.heightAnchor.constraint(equalToConstant: 50),
            signUpButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            
            footerView.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 20),
            footerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            footerView.heightAnchor.constraint(equalToConstant: 100),
            footerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9)
        ])
    }
    
    // MARK: - Selectors
    @objc private func signUpButtonTapped() {
        if let email = emailTextField.text, let password = passwordTextField.text {
            viewModel.signUpUser(with: email, and: password)
        }
    }
    
    @objc private func emailFieldDidChange() {
        viewModel.email = emailTextField.text ?? ""
    }
    
    @objc private func passwordFieldDidChange() {
        viewModel.password = passwordTextField.text ?? ""
    }
    
    @objc private func confirmationFieldDidChange() {
        viewModel.confirmPass = confirmationTextField.text ?? ""
    }
    
    @objc private func signInPressed() {
        navigationController?.popToRootViewController(animated: true)
    }
}

extension SignUpViewController: SignUpViewControllerProtocol {
    func showSignInErrorAlert(message: String) {
        let alert = UIAlertController(title: "Sign In Failed", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alert, animated: true)
    }
    
    func setupButtons() {
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        footerView.footerButton.addTarget(self, action: #selector(signInPressed), for: .touchUpInside)
    }
    
    func setupFields() {
        emailTextField.addTarget(self, action: #selector(emailFieldDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(passwordFieldDidChange), for: .editingChanged)
        confirmationTextField.addTarget(self, action: #selector(confirmationFieldDidChange), for: .editingChanged)
    }
}
