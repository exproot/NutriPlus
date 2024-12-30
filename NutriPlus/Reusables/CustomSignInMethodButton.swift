//
//  CustomSignInMethodButton.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 21.10.2024.
//

import UIKit

final class CustomSignInMethodButton: UIButton {
  enum SignInType {
    case apple, gmail
  }

  // MARK: - UI Components
  private var iconImageView: CustomImageView?

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

    switch type {
    case .apple:
      iconImageView = CustomImageView(isSystemImage: true, imageString: "apple.logo", contentMode: .scaleAspectFit)
    case .gmail:
      iconImageView = CustomImageView(isSystemImage: false, imageString: "google_g_icon", contentMode: .scaleAspectFit)
    }
    if let iconImageView {
      iconImageView.tintColor = .label
      addSubview(iconImageView)

      NSLayoutConstraint.activate([
        iconImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        iconImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        iconImageView.heightAnchor.constraint(equalToConstant: 20),
        iconImageView.widthAnchor.constraint(equalToConstant: 20)
      ])
    }
  }
}
