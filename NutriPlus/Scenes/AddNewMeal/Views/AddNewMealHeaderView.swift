//
//  AddNewMealHeaderView.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 18.12.2024.
//

import UIKit

final class AddNewMealHeaderView: UIView {
  // MARK: - UI Components
  private lazy var titleLabel = CustomLabel(text: "Add New Meal", fontSize: 28, fontWeight: .bold, textColor: .white)
  lazy var segmentedControl = CustomSegmentedControl(items: ["Manual", "AI Scan"], backgroundColor: .systemBackground)

  // MARK: - View Lifecycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - UI Setup
  private func setupUI() {
    backgroundColor = .systemOrange
    layer.cornerRadius = 35
    translatesAutoresizingMaskIntoConstraints = false

    addSubview(titleLabel)
    addSubview(segmentedControl)

    NSLayoutConstraint.activate([
      titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -16),
      titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),

      segmentedControl.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
      segmentedControl.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      segmentedControl.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.75),
      segmentedControl.heightAnchor.constraint(equalToConstant: 45),
    ])
  }
}
