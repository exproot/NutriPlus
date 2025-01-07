//
//  ProfileHeaderView.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 30.12.2024.
//

import UIKit

final class ProfileHeaderView: UIView {
  // MARK: - UI Components
  lazy var backgroundImage = CustomImageView(isSystemImage: false, imageString: "Wavy-BG", contentMode: .scaleAspectFill)
  lazy var profileImageView = CustomImageView(contentMode: .scaleAspectFit)
  lazy var dateLabel = CustomLabel(text: "...", fontSize: 14, fontWeight: .regular, textColor: .white)
  lazy var greetingLabel = CustomLabel(text: "...", fontSize: 28, fontWeight: .bold, textColor: .white)

  override init(frame: CGRect) {
    super.init(frame: .zero)
    setupUI()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configure(imageString: String, isSystemImage: Bool = true, imageTintColor: UIColor = .white, dateText: String, greetingText: String) {
    setProfileImage(isSystemImage: isSystemImage, imageString: imageString, imageTintColor: imageTintColor)
    dateLabel.text = dateText
    greetingLabel.text = greetingText
  }

  private func setProfileImage(isSystemImage: Bool, imageString: String, imageTintColor: UIColor) {
    let image = isSystemImage ? UIImage(systemName: imageString)?.withTintColor(imageTintColor, renderingMode: .alwaysOriginal) : UIImage(named: imageString)

    profileImageView.image = image
  }

  // MARK: - UI Setup
  private func setupUI() {
    backgroundColor = .black
    layer.cornerRadius = 40
    layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    backgroundImage.alpha = 0.55
    clipsToBounds = true
    translatesAutoresizingMaskIntoConstraints = false

    addSubview(backgroundImage)
    addSubview(profileImageView)
    addSubview(dateLabel)
    addSubview(greetingLabel)

    NSLayoutConstraint.activate([
      backgroundImage.topAnchor.constraint(equalTo: self.topAnchor),
      backgroundImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      backgroundImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      backgroundImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),

      profileImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
      profileImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25),
      profileImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5),
      profileImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),

      dateLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 4),
      dateLabel.topAnchor.constraint(equalTo: profileImageView.topAnchor, constant: 12),

      greetingLabel.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor),
      greetingLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor)

    ])
  }
}
