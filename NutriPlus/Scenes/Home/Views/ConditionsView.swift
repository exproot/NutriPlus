//
//  ConditionsView.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 31.12.2024.
//

import UIKit

final class ConditionsView: UIView {
  lazy var gradientView = CustomGradientBarView()
  lazy var titleLabel = CustomLabel(text: "BMI : 19.6 (Underweight)", fontSize: 24, fontWeight: .bold, textColor: .white, numberOfLines: 0)

  override init(frame: CGRect) {
    super.init(frame: .zero)
    translatesAutoresizingMaskIntoConstraints = false
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - UI Setup
  private func setupUI() {
    layer.cornerRadius = 20
    gradientView.layer.cornerRadius = 20
    gradientView.clipsToBounds = true

    addSubview(gradientView)
    addSubview(titleLabel)

    NSLayoutConstraint.activate([
      gradientView.topAnchor.constraint(equalTo: self.topAnchor),
      gradientView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      gradientView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      gradientView.bottomAnchor.constraint(equalTo: self.bottomAnchor),

      titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
    ])
  }
}
