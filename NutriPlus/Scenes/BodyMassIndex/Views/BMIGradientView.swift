//
//  BMIGradientView.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 28.12.2024.
//

import UIKit

final class BMIGradientView: UIView {
  private let gradientLayer = CAGradientLayer()

  override init(frame: CGRect) {
    super.init(frame: frame)
    layer.addSublayer(gradientLayer)
    translatesAutoresizingMaskIntoConstraints = false
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    gradientLayer.frame = self.bounds
  }

  func setGradient(colors: [UIColor]) {
    gradientLayer.colors = colors.map { $0.cgColor }
    gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
    gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
  }
}
