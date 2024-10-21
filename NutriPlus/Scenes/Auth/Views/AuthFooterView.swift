//
//  AuthFooterView.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 21.10.2024.
//

import UIKit

final class AuthFooterView: UIView {
    enum AuthType {
        case signIn, signUp
    }
    
    // MARK: - UI Components
    private lazy var footerLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 14, weight: .regular)
        lbl.textColor = .label
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    var footerButton: CustomFooterButton!
    
    private lazy var footerStack: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 5
        sv.distribution = .equalSpacing
        sv.alignment = .center
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    let forgotPassButton = CustomFooterButton(title: "Forgot Password", frame: .zero)
    
    init(type: AuthType, frame: CGRect) {
        super.init(frame: frame)
        setupUI(with: type)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    private func setupUI(with type: AuthType) {
        switch type {
        case .signIn:
            footerLabel.text = "Don't have an account?"
            footerButton = CustomFooterButton(title: "Sign Up.", frame: .zero)
            addSubview(forgotPassButton)
            
            NSLayoutConstraint.activate([
                forgotPassButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 5),
                forgotPassButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                forgotPassButton.heightAnchor.constraint(equalToConstant: 50)
            ])
        case .signUp:
            footerLabel.text = "Already have an account?"
            footerButton = CustomFooterButton(title: "Sign In.", frame: .zero)
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        
        footerStack.addArrangedSubview(footerLabel)
        footerStack.addArrangedSubview(footerButton)
        addSubview(footerStack)
        
        NSLayoutConstraint.activate([
            footerStack.topAnchor.constraint(equalTo: self.topAnchor),
            footerStack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            footerStack.heightAnchor.constraint(equalToConstant: 80),
            
        ])
    }
}
