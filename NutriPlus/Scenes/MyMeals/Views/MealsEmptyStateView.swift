//
//  EmptyStateView.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 9.01.2025.
//

import UIKit

final class MealsEmptyStateView: UIView {
  private let imageView = CustomImageView(image: UIImage(systemName: "fork.knife")?.withTintColor(.secondarySystemBackground, renderingMode: .alwaysOriginal), contentMode: .scaleAspectFit)
  private let titleLabel = CustomLabel(text: "No Meals Yet", fontSize: 28, fontWeight: .bold, textColor: .label)
  private let descLabel = CustomLabel(text: "You can add meals by tapping the + button below.", fontSize: 16, fontWeight: .regular, textColor: .secondaryLabel, alignment: .center, numberOfLines: 0)

  override init(frame: CGRect) {
    super.init(frame: .zero)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - UI Setup
  private func setupUI() {
    translatesAutoresizingMaskIntoConstraints = false
    addSubview(imageView)
    addSubview(titleLabel)
    addSubview(descLabel)

    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: self.topAnchor),
      imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      imageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.7),

      titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
      titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),

      descLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
      descLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      descLabel.widthAnchor.constraint(equalTo: self.widthAnchor)
    ])
  }
}
