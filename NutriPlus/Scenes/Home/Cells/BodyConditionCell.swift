//
//  BodyConditionCell.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 2.01.2025.
//

import UIKit

class BodyConditionCell: UICollectionViewCell {
  static let reuseIdentifier = "BodyConditionCell"

  // MARK: - UI Components
  private lazy var conditionView = ConditionsView()

  override init(frame: CGRect) {
    super.init(frame: .zero)
    setupUI()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configure(_ viewModel: ConditionCellViewModel) {
    conditionView.gradientView.setGradient(colors: viewModel.colors)
    conditionView.titleLabel.text = viewModel.title
  }
  
  // MARK: - UI Setup
  private func setupUI() {
    contentView.addSubview(conditionView)

    NSLayoutConstraint.activate([
      conditionView.topAnchor.constraint(equalTo: contentView.topAnchor),
      conditionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      conditionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      conditionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
    ])
  }
}
