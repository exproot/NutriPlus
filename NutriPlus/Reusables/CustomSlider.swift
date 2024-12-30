//
//  CustomSlider.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 18.12.2024.
//

import UIKit

final class CustomSlider: UISlider {
  private let trackHeight: CGFloat = 12

  override func trackRect(forBounds bounds: CGRect) -> CGRect {
    let track = super.trackRect(forBounds: bounds)
    return CGRect(x: track.origin.x, y: track.origin.y, width: track.width, height: trackHeight)
  }

  init(minVal: Float, maxVal: Float, thumbColor: UIColor, tintColor: UIColor = .black, value: Float = 0.0) {
    super.init(frame: .zero)
    self.minimumValue = minVal
    self.maximumValue = maxVal
    self.value = value
    self.tintColor = tintColor
    translatesAutoresizingMaskIntoConstraints = false

    let configuration = UIImage.SymbolConfiguration(pointSize: 20)

    let image = UIImage(systemName: "rectangle.fill", withConfiguration: configuration)?.withTintColor(thumbColor, renderingMode: .alwaysOriginal)
    self.setThumbImage(image, for: .normal)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
