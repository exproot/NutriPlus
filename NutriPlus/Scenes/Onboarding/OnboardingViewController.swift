//
//  OnboardingViewController.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 23.10.2024.
//

import UIKit

final class OnboardingViewController: UIViewController {
    // MARK: - UI Components
    private var gradientLayer: CAGradientLayer?
    
    private lazy var backgroundImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = UIImage(named: "onboard")
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private lazy var iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.image = UIImage(systemName: "leaf.fill")
        iv.tintColor = .white
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 32, weight: .bold)
        lbl.textColor = .white
        lbl.text = "Welcome To \n NutriPlus"
        lbl.numberOfLines = 2
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 16, weight: .regular)
        lbl.textColor = .white
        lbl.text = "Your personal nutrition AI assistant 🤖"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private lazy var continueButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "Get Started"
        config.cornerStyle = .capsule
        config.buttonSize = .large
        config.baseBackgroundColor = .systemOrange
        
        let btn = UIButton(configuration: config)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer?.frame = backgroundImageView.bounds
    }
    
    // MARK: - UI Setup
    private func applyVerticalGradient() {
        gradientLayer?.removeFromSuperlayer()
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.black.withAlphaComponent(0).cgColor, UIColor.black.withAlphaComponent(1).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        gradientLayer.frame = view.bounds
        
        // Update the gradient when layout changes
        gradientLayer.frame = backgroundImageView.bounds
        backgroundImageView.layer.insertSublayer(gradientLayer, at: 0)
        
        self.gradientLayer = gradientLayer
    }
    
    private func setupUI() {
        view.addSubview(backgroundImageView)
        view.addSubview(iconImageView)
        view.addSubview(titleLabel)
        view.addSubview(subTitleLabel)
        view.addSubview(continueButton)
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            iconImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 100),
            iconImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            iconImageView.heightAnchor.constraint(equalToConstant: 70),
            iconImageView.widthAnchor.constraint(equalToConstant: 70),
            
            titleLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            subTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            continueButton.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 20),
            continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            continueButton.heightAnchor.constraint(equalToConstant: 55),
            continueButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
        ])
        
        applyVerticalGradient()
    }
    
    // MARK: - Selectors
    @objc private func continueButtonTapped() {
        UserDefaults.standard.set(true, forKey: "openedApp")
        
        if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
            sceneDelegate.checkAuthentication()
        }
    }
}
