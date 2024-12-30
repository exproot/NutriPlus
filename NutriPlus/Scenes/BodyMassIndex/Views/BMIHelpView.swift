//
//  BMIHelpView.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 29.12.2024.
//

import UIKit

final class BMIHelpView: UIView {
  // MARK: - UI Components
  private lazy var imageView: UIImageView = {
    let customImageView = UIImageView()
    customImageView.contentMode = .scaleAspectFill
    customImageView.translatesAutoresizingMaskIntoConstraints = false
    return customImageView
  }()

  private lazy var descriptionLabel = CustomLabel(text: "", fontSize: 16, fontWeight: .regular, textColor: .label)

  init(text: String, imageString: String) {
    super.init(frame: .zero)
    descriptionLabel.text = text
    imageView.image = UIImage(named: imageString)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - UI Setup
  private func setupUI() {
    descriptionLabel.numberOfLines = 0
    addSubview(imageView)
    addSubview(descriptionLabel)

    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: self.topAnchor),
      imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      imageView.widthAnchor.constraint(equalToConstant: 40),
      imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),

      descriptionLabel.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
      descriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
      descriptionLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8),
      descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
    ])
  }
}
