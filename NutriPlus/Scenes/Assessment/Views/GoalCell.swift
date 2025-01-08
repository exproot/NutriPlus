//
//  GoalCell.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 24.10.2024.
//

import UIKit

final class GoalCell: UITableViewCell {
  static let identifier = "GoalCell"

  // MARK: - UI Components
  private lazy var titleLabel = CustomLabel(text: "", fontSize: 20, fontWeight: .semibold, textColor: .black)

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupUI()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configure(with title: String, isSelected: Bool) {
    titleLabel.text = title
    titleLabel.textColor = isSelected ? .white : .black
    contentView.backgroundColor = isSelected ? .black : .gray.withAlphaComponent(0.2)
  }

  // MARK: - UI Setup
  private func setupUI() {
    backgroundColor = .clear
    contentView.layer.cornerRadius = 10
    contentView.layer.masksToBounds = true
    contentView.addSubview(titleLabel)
    selectionStyle = .none

    NSLayoutConstraint.activate([
      titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
      titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20)
    ])
  }
}
