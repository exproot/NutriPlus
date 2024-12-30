//
//  BodyMeasurementView.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 30.12.2024.
//

import UIKit

final class BodyMeasurementView: UIView {
  enum MeasurementType {
    case height
    case weight
  }

  // MARK: - UI Components
  private let titleLabel = CustomLabel(text: "", fontSize: 28, fontWeight: .bold, textColor: .black, alignment: .center, numberOfLines: 0)
  lazy var valueLabel = CustomLabel(text: "", fontSize: 48, fontWeight: .bold, textColor: .black, alignment: .center)
  lazy var continueButton = CustomButton()
  var unitSelector: CustomSegmentedControl
  var valueSlider: CustomSlider
  var animationView: CustomAnimation?
  var imageView: CustomImageView?

  init(measurementType: MeasurementType) {
    switch measurementType {
    case .height:
      titleLabel.text = "What's your current height right now?"
      unitSelector = CustomSegmentedControl(items: ["Centimeter", "Feet/Inch"], backgroundColor: .white, selectedColor: .white, textColor: .black, selectedTextColor: .black)
      valueSlider = CustomSlider(minVal: 50, maxVal: 250, thumbColor: .black, value: 170.0)
      imageView = CustomImageView(isSystemImage: false, imageString: "measure-height")
    case .weight:
      titleLabel.text = "What's your current weight right now?"
      unitSelector = CustomSegmentedControl(items: ["Kilogram", "Pound"], backgroundColor: .white, selectedColor: .white, textColor: .black, selectedTextColor: .black)
      valueSlider = CustomSlider(minVal: 35, maxVal: 200, thumbColor: .black, value: 60.0)
      animationView = CustomAnimation(name: "WeightScan", loopMode: .loop, contentMode: .scaleAspectFill)
    }
    super.init(frame: .zero)
    setupUI()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - UI Setup
  private func setupUI() {
    translatesAutoresizingMaskIntoConstraints = false
    titleLabel.numberOfLines = 0
    addSubview(titleLabel)
    addSubview(unitSelector)
    addSubview(valueLabel)
    addSubview(valueSlider)
    addSubview(continueButton)

    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
      titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
      titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),

      unitSelector.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
      unitSelector.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      unitSelector.heightAnchor.constraint(equalToConstant: 50),
      unitSelector.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.65),

      valueLabel.topAnchor.constraint(equalTo: unitSelector.bottomAnchor, constant: 40),
      valueLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),

      valueSlider.topAnchor.constraint(equalTo: valueLabel.bottomAnchor, constant: 20),
      valueSlider.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      valueSlider.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
      valueSlider.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),

      continueButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
      continueButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
      continueButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
      continueButton.heightAnchor.constraint(equalToConstant: 50)
    ])

    if let animationView {
      addSubview(animationView)
      
      NSLayoutConstraint.activate([
        animationView.topAnchor.constraint(equalTo: valueSlider.bottomAnchor, constant: 60),
        animationView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        animationView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.3),
        animationView.widthAnchor.constraint(equalToConstant: 150),
      ])

      animationView.play()
    }

    if let imageView {
      addSubview(imageView)

      NSLayoutConstraint.activate([
        imageView.topAnchor.constraint(equalTo: valueSlider.bottomAnchor, constant: 60),
        imageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.28),
        imageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5),
        imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
      ])
    }
  }
}
