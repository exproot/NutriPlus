//
//  NutriAIView.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 1.01.2025.
//

import UIKit

final class NutriAIView: UIView {
  private lazy var backgroundImage = CustomImageView(isSystemImage: false, imageString: "AI-Background", contentMode: .scaleAspectFill)
  private lazy var geminiTag = TransparentView(text: "GEMINI")

  lazy var chatButton = CustomButton(isSystemImage: true, imageString: "plus.message.fill", backgroundColor: .darkGray.withAlphaComponent(0.6), foregroundColor: .white)

  lazy var nutriLabel = CustomLabel(text: "Nutri AI", fontSize: 24, fontWeight: .bold, textColor: .white)

  override init(frame: CGRect) {
    super.init(frame: .zero)
    translatesAutoresizingMaskIntoConstraints = false
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - UI Setup
  private func setupUI() {
    layer.cornerRadius = 20
    geminiTag.layer.cornerRadius = 6
    clipsToBounds = true

    addSubview(backgroundImage)
    addSubview(geminiTag)
    addSubview(chatButton)
    addSubview(nutriLabel)

    NSLayoutConstraint.activate([
      backgroundImage.topAnchor.constraint(equalTo: self.topAnchor),
      backgroundImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
      backgroundImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      backgroundImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),

      geminiTag.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
      geminiTag.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
      geminiTag.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.16),
      geminiTag.heightAnchor.constraint(equalTo: geminiTag.widthAnchor, multiplier: 0.35),

      chatButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
      chatButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
      chatButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.135),
      chatButton.heightAnchor.constraint(equalTo: chatButton.widthAnchor),

      nutriLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
      nutriLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
    ])
  }
}
