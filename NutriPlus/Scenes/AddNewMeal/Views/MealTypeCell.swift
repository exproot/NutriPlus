//
//  MealTypeCell.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 18.12.2024.
//

import UIKit

final class MealTypeCell: UICollectionViewCell {
  static let reuseID = "MealTypeCell"

  // MARK: - UI Components
  private lazy var titleLabel = CustomLabel(text: "", fontSize: 16, fontWeight: .semibold, textColor: .label)

  // MARK: - View Lifecycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configure(title: String) {
    titleLabel.text = title
  }

  // MARK: - UI Setup
  private func setupViews() {
    let normalView = UIView(frame: bounds)
    normalView.backgroundColor = .systemGray6
    normalView.layer.cornerRadius = 10

    let squareImage = UIImageView(image: UIImage(systemName: "square")?.withTintColor(.label, renderingMode: .alwaysOriginal))
    squareImage.translatesAutoresizingMaskIntoConstraints = false
    normalView.addSubview(squareImage)

    NSLayoutConstraint.activate([
      squareImage.centerYAnchor.constraint(equalTo: normalView.centerYAnchor),
      squareImage.trailingAnchor.constraint(equalTo: normalView.trailingAnchor, constant: -8),
      squareImage.heightAnchor.constraint(equalToConstant: 25),
      squareImage.widthAnchor.constraint(equalToConstant: 25),
    ])

    let selectedView = UIView(frame: bounds)
    selectedView.backgroundColor = .systemGray6
    selectedView.layer.cornerRadius = 10

    let dotSquareImage = UIImageView(image: UIImage(systemName: "dot.square")?.withTintColor(.label, renderingMode: .alwaysOriginal))
    dotSquareImage.translatesAutoresizingMaskIntoConstraints = false
    selectedView.addSubview(dotSquareImage)

    NSLayoutConstraint.activate([
      dotSquareImage.centerYAnchor.constraint(equalTo: selectedView.centerYAnchor),
      dotSquareImage.trailingAnchor.constraint(equalTo: selectedView.trailingAnchor, constant: -8),
      dotSquareImage.heightAnchor.constraint(equalToConstant: 25),
      dotSquareImage.widthAnchor.constraint(equalToConstant: 25),
    ])

    backgroundView = normalView
    selectedBackgroundView = selectedView
  }

  private func setupUI() {
    setupViews()

    self.addSubview(titleLabel)

    NSLayoutConstraint.activate([
      titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      titleLabel.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
    ])
  }
}
