//
//  MacronutrientCell.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 7.01.2025.
//

import UIKit

final class MacronutrientCell: UITableViewCell {
  static let reuseIdentifier = "MacronutrientCell"

  // MARK: - UI Components
  private lazy var circleImageView = CustomImageView(contentMode: .scaleAspectFit)
  private lazy var macroLabel = CustomLabel(text: "", fontSize: 18, fontWeight: .medium, textColor: .label)
  private lazy var amountLabel = CustomLabel(text: "", fontSize: 18, fontWeight: .medium, textColor: .lightGray)

  // MARK: - Cell Lifecycle
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configure(type: MacronutrientType, amount: Double) {
    macroLabel.text = type.text
    circleImageView.image = UIImage(systemName: "circle.fill")?.withTintColor(type.color, renderingMode: .alwaysOriginal)
    amountLabel.text = "\(amount.formatted)g"
  }

  // MARK: - UI Setup
  private func setupUI() {
    contentView.addSubview(circleImageView)
    contentView.addSubview(macroLabel)
    contentView.addSubview(amountLabel)

    NSLayoutConstraint.activate([
      circleImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      circleImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
      circleImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.65),
      circleImageView.widthAnchor.constraint(equalToConstant: 20),

      macroLabel.leadingAnchor.constraint(equalTo: circleImageView.trailingAnchor, constant: 16),
      macroLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),

      amountLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      amountLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
    ])
  }
}
