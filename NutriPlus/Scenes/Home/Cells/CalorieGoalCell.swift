//
//  CalorieGoalCell.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 2.01.2025.
//

import UIKit

final class CalorieGoalCell: UICollectionViewCell {
  static let reuseIdentifier = "CalorieGoalCell"

  // MARK: - UI Components
  private lazy var calorieSection = CalorieGoalView()

  override init(frame: CGRect) {
    super.init(frame: .zero)
    setupUI()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configure(_ viewModel: CalorieGoalCellViewModel) {
    calorieSection.calorieLabel.text = viewModel.title
    calorieSection.progressView.setProgress(to: viewModel.progressValue)
  }

  // MARK: - UI Setup
  private func setupUI() {
    contentView.addSubview(calorieSection)

    NSLayoutConstraint.activate([
      calorieSection.topAnchor.constraint(equalTo: contentView.topAnchor),
      calorieSection.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      calorieSection.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      calorieSection.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
    ])
  }
}
