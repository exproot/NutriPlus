//
//  AIPromotionCell.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 2.01.2025.
//

import UIKit

final class AIPromotionCell: UICollectionViewCell {
  static let reuseIdentifier = "AIPromotionCell"

  // MARK: - UI Components
  private lazy var nutriAiView = NutriAIView()

  override init(frame: CGRect) {
    super.init(frame: .zero)
    setupUI()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configure(_ viewModel: AIPromotionCellViewModel) {
    nutriAiView.nutriLabel.text = viewModel.title
  }

  // MARK: - UI Setup
  private func setupUI() {
    contentView.addSubview(nutriAiView)

    NSLayoutConstraint.activate([
      nutriAiView.topAnchor.constraint(equalTo: contentView.topAnchor),
      nutriAiView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      nutriAiView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      nutriAiView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
    ])
  }
}
