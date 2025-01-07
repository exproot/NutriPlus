//
//  BMRCircularProgressView.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 29.12.2024.
//

import UIKit

final class BMRCircularProgressView: UIView {
  // MARK: - UI Components
  private let progressLayer = CAShapeLayer()
  private let trackLayer = CAShapeLayer()

  // MARK: - View Lifecycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    translatesAutoresizingMaskIntoConstraints = false
    setupView()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    if trackLayer.path == nil || progressLayer.path == nil {
      let circularPath = UIBezierPath(
        arcCenter: CGPoint(x: bounds.midX, y: bounds.midY),
        radius: bounds.width / 2.5,
        startAngle: -(.pi / 2),
        endAngle: 1.5 * .pi,
        clockwise: true
      )

      trackLayer.path = circularPath.cgPath
      progressLayer.path = circularPath.cgPath
    }
  }

  // MARK: - Methods
  func setProgress(_ value: CGFloat, color: UIColor) {
    progressLayer.strokeEnd = value
  }

  // MARK: - UI Setup
  private func setupProgressCircle() {
    progressLayer.strokeColor = UIColor.systemOrange.cgColor
    progressLayer.lineWidth = 16
    progressLayer.fillColor = UIColor.clear.cgColor
    progressLayer.lineCap = .round
    progressLayer.strokeEnd = 0
    layer.addSublayer(progressLayer)
  }

  private func setupTrackCircle() {
    trackLayer.strokeColor = UIColor.systemGray6.cgColor
    trackLayer.lineWidth = 16
    trackLayer.fillColor = UIColor.clear.cgColor
    trackLayer.lineCap = .round
    layer.addSublayer(trackLayer)
  }

  private func setupView() {
    setupTrackCircle()
    setupProgressCircle()
  }
}
