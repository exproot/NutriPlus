//
//  CustomBarView.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 6.01.2025.
//

import UIKit

final class CustomBarView: UIView {
  private lazy var progressBar: UIView = {
    let customView = UIView()
    customView.layer.cornerRadius = 10
    customView.translatesAutoresizingMaskIntoConstraints = false
    return customView
  }()
  private lazy var percentageLabel = CustomLabel(text: "", fontSize: 16, fontWeight: .bold, textColor: .label)
  private var progressBarHeightConstraint: NSLayoutConstraint?

  // MARK: - View Lifecycle
  override init(frame: CGRect) {
    super.init(frame: .zero)
    setupView()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Methods
  func updateProgressBar(percentage: Double, color: UIColor) {
    percentageLabel.text = "\(percentage.formatted)%"
    progressBar.backgroundColor = color

    if let existingHeightConstraint = progressBarHeightConstraint {
      progressBar.removeConstraint(existingHeightConstraint)
    }

    let newHeightConstraint = progressBar.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: CGFloat(percentage) / 100)
    newHeightConstraint.isActive = true
    progressBarHeightConstraint = newHeightConstraint
  }

  // MARK: - UI Setup
  private func setupView() {
    self.layer.cornerRadius = 10
    self.backgroundColor = .systemGray5
    self.addSubview(progressBar)
    self.addSubview(percentageLabel)
    self.translatesAutoresizingMaskIntoConstraints = false

    let initialHeightConstraint = progressBar.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0)
    initialHeightConstraint.isActive = true
    progressBarHeightConstraint = initialHeightConstraint

    NSLayoutConstraint.activate([
      progressBar.bottomAnchor.constraint(equalTo: self.bottomAnchor),
      progressBar.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      progressBar.trailingAnchor.constraint(equalTo: self.trailingAnchor),

      percentageLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      percentageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
    ])
  }
}
