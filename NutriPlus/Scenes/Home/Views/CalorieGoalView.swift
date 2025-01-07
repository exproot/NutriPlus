//
//  CalorieGoalView.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 30.12.2024.
//

import UIKit

final class CalorieGoalView: UIView {
  // MARK: - UI Components
  lazy var calorieLabel = CustomLabel(text: "", fontSize: 30, fontWeight: .bold, textColor: .white)
  let progressView = CalorieProgressView()

  override init(frame: CGRect) {
    super.init(frame: .zero)
    setupUI()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - UI Setup
  private func setupUI() {
    backgroundColor = .systemOrange
    layer.cornerRadius = 20
    translatesAutoresizingMaskIntoConstraints = false

    addSubview(calorieLabel)
    addSubview(progressView)

    NSLayoutConstraint.activate([
      calorieLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
      calorieLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),

      progressView.topAnchor.constraint(equalTo: calorieLabel.bottomAnchor, constant: 20),
      progressView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
      progressView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
      progressView.heightAnchor.constraint(equalToConstant: 35)
    ])
  }
}
