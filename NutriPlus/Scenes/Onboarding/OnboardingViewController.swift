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
  
  private lazy var backgroundImageView = CustomImageView(isSystemImage: false, imageString: "onboard", contentMode: .scaleAspectFit)
  private lazy var iconImageView = CustomImageView(isSystemImage: true, imageString: "leaf.fill", contentMode: .scaleAspectFill)
  private lazy var titleLabel = CustomLabel(text: "Welcome To \n NutriPlus", fontSize: 32, fontWeight: .bold, textColor: .white, alignment: .center, numberOfLines: 2)
  private lazy var subTitleLabel = CustomLabel(text: "Your personal nutrition AI assistant 🤖", fontSize: 16, fontWeight: .regular, textColor: .white)
  private lazy var continueButton = CustomButton(title: "Get Started", backgroundColor: .systemOrange, cornerStyle: .capsule)
  
  // MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    iconImageView.tintColor = .white
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
    
    self.checkAuthViaSceneDelegate()
  }
}
