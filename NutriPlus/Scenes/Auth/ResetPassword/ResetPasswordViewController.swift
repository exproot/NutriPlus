//
//  ResetPasswordViewController.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 21.10.2024.
//

import UIKit

final class ResetPasswordViewController: UIViewController {
    // MARK: - UI Components
    private lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 28, weight: .bold)
        lbl.text = "Reset Password"
        lbl.textColor = .label
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 18, weight: .regular)
        lbl.text = "Select what method you'd like to reset."
        lbl.textColor = .secondaryLabel
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private lazy var resetPassButton: UIButton = {
        let btn = UIButton()
        var config = UIButton.Configuration.gray()
        config.cornerStyle = .medium
        config.buttonSize = .large
        config.title = "Send via Email"
        config.subtitle = "Seamlessly reset your password via email adress."
        config.image = UIImage(systemName: "envelope.fill")
        config.imagePadding = 10
        config.titlePadding = 5
        config.baseForegroundColor = .label
        config.image!.withTintColor(.systemOrange)
        btn.configuration = config
        btn.imageView?.tintColor = .systemOrange
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(titleLabel)
        view.addSubview(subTitleLabel)
        view.addSubview(resetPassButton)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            subTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            resetPassButton.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 40),
            resetPassButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resetPassButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9)
        ])
    }
}
