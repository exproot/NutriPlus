//
//  CalorieProgressView.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 30.12.2024.
//

import UIKit

final class CalorieProgressView: UIView {
  private let progressLayer = CAShapeLayer()
  private let backgroundLayer = CAShapeLayer()

  override init(frame: CGRect) {
    super.init(frame: .zero)
    translatesAutoresizingMaskIntoConstraints = false
    setupLayers()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    if backgroundLayer.path == nil || progressLayer.path == nil  {
      let path = UIBezierPath()
      path.move(to: CGPoint(x: bounds.minX, y: bounds.midY))
      path.addLine(to: CGPoint(x: bounds.maxX, y: bounds.midY))

      backgroundLayer.path = path.cgPath
      progressLayer.path = path.cgPath
    }
  }

  func setProgress(to value: CGFloat) {
    progressLayer.strokeEnd = value
  }

  private func setupLayers() {
    backgroundLayer.strokeColor = UIColor.white.withAlphaComponent(0.3).cgColor
    backgroundLayer.lineWidth = 35
    backgroundLayer.lineCap = .round
    backgroundLayer.fillColor = UIColor.clear.cgColor
    layer.addSublayer(backgroundLayer)

    progressLayer.strokeColor = UIColor.white.cgColor
    progressLayer.lineWidth = 35
    progressLayer.lineCap = .round
    progressLayer.fillColor = UIColor.clear.cgColor
    progressLayer.strokeEnd = 0
    layer.addSublayer(progressLayer)
  }
}
