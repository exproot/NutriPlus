//
//  CustomTextField.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 21.10.2024.
//

import UIKit

final class CustomTextField: UITextField {
    enum FieldType {
        case mail, password, confirmation
    }
    
    // MARK: - UI Components
    private lazy var headerLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 14, weight: .semibold)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    init(type: FieldType, frame: CGRect) {
        super.init(frame: frame)
        setupUI(type: type)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    private func setupUI(type: FieldType) {
        addSubview(headerLabel)
        
        backgroundColor = .systemGray6
        spellCheckingType = .no
        autocapitalizationType = .none
        autocorrectionType = .no
        layer.cornerRadius = 20
        translatesAutoresizingMaskIntoConstraints = false
        
        switch type {
        case .mail:
            keyboardType = .emailAddress
            placeholder = "Enter email adress"
            headerLabel.text = "Email Adress"
            addIconWithPadding(UIImage(systemName: "envelope.circle.fill")!, padding: 20, isLeftView: true)
        case .password:
            isSecureTextEntry = true
            keyboardType = .default
            returnKeyType = .done
            placeholder = "Enter password"
            headerLabel.text = "Password"
            addIconWithPadding(UIImage(systemName: "lock.fill")!, padding: 20, isLeftView: true)
        case .confirmation:
            isSecureTextEntry = true
            keyboardType = .default
            returnKeyType = .done
            headerLabel.text = "Confirm password"
            addIconWithPadding(UIImage(systemName: "lock.fill")!, padding: 20, isLeftView: true)
        }
        
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: -25),
            headerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        ])
        
    }
}
