//
//  ChatNavigationTitleStackView.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 23.12.2024.
//

import UIKit

final class ChatNavigationTitleStackView: UIStackView {
  // MARK: - UI Components
  private lazy var imageView = CustomImageView(imageString: "NutriBot", contentMode: .scaleAspectFit, imageTintColor: .systemOrange)
//  private lazy var imageView: UIImageView = {
//    let customImageView = UIImageView(image: UIImage(named: "NutriBot")?.withTintColor(.systemOrange, renderingMode: .alwaysOriginal))
//    customImageView.contentMode = .scaleAspectFit
//    customImageView.translatesAutoresizingMaskIntoConstraints = false
//    return customImageView
//  }()

  private lazy var titleLabel = CustomLabel(text: "Nutri AI", fontSize: 18, fontWeight: .semibold, textColor: .label)

  init() {
    super.init(frame: .zero)
    setupUI()
  }

  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - UI Setup
  private func setupUI() {
    axis = .horizontal
    alignment = .center
    spacing = 8

    imageView.widthAnchor.constraint(equalToConstant: 32).isActive = true
    imageView.heightAnchor.constraint(equalToConstant: 32).isActive = true

    addArrangedSubview(imageView)
    addArrangedSubview(titleLabel)
  }
}
