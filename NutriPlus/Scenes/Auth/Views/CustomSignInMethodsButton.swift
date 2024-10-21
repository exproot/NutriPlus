//
//  CustomSignInMethodsButton.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 21.10.2024.
//

import UIKit

final class CustomSignInMethodsButton: UIButton {
    enum SignInType {
        case apple, gmail
    }
    
    // MARK: - UI Components
    private lazy var iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.tintColor = .label
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    init(type: SignInType, frame: CGRect) {
        super.init(frame: frame)
        setupUI(type: type)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    private func setupUI(type: SignInType) {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
        layer.cornerRadius = 25
        
        addSubview(iconImageView)
        
        switch type {
        case .apple:
            iconImageView.image = UIImage(systemName: "apple.logo")
        case .gmail:
            iconImageView.image = UIImage(named: "google_g_icon")
        }
        
        NSLayoutConstraint.activate([
            iconImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            iconImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            iconImageView.heightAnchor.constraint(equalToConstant: 20),
            iconImageView.widthAnchor.constraint(equalToConstant: 20)
        ])
    }
}
