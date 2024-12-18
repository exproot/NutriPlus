//
//  MacroSliderView.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 18.12.2024.
//

import UIKit

final class MacroSliderView: UIView {
  private lazy var imageView: UIImageView = {
    let customImageView = UIImageView()
    customImageView.contentMode = .scaleAspectFit
    customImageView.clipsToBounds = true
    customImageView.translatesAutoresizingMaskIntoConstraints = false
    return customImageView
  }()

  private lazy var gramLabel = CustomLabel(text: "0g", fontSize: 16, fontWeight: .regular, textColor: .secondaryLabel)
  private lazy var titleLabel = CustomLabel(text: "", fontSize: 16, fontWeight: .bold, textColor: .label)
  private var slider: CustomSlider?

  init(title: String, sliderColor: UIColor) {
    super.init(frame: .zero)
    setupUI(
      title: title,
      imageString: nil,
      sliderMinValue: 10,
      sliderMaxValue: 30,
      sliderColor: sliderColor
    )
  }

  init(title: String, imageString: String, sliderMinValue: Float, sliderMaxValue: Float, sliderColor: UIColor) {
    super.init(frame: .zero)
    setupUI(title: title, imageString: imageString, sliderMinValue: sliderMinValue, sliderMaxValue: sliderMaxValue, sliderColor: sliderColor)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - UI Setup
  private func setupUI(title: String, imageString: String?, sliderMinValue: Float, sliderMaxValue: Float, sliderColor: UIColor) {
    slider = CustomSlider(minVal: sliderMinValue, maxVal: sliderMaxValue, thumbColor: sliderColor)
    titleLabel.text = title

    if
      let imageString = imageString,
      let slider = slider
    {
      imageView.image = UIImage(named: imageString)
      slider.tintColor = sliderColor

      addSubview(imageView)
      addSubview(gramLabel)
      addSubview(slider)
      addSubview(titleLabel)

      NSLayoutConstraint.activate([
        gramLabel.topAnchor.constraint(equalTo: self.topAnchor),
        gramLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),

        imageView.topAnchor.constraint(equalTo: self.topAnchor),
        imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
        imageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.1),
        imageView.heightAnchor.constraint(equalToConstant: 45),

        slider.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
        slider.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8),
        slider.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        slider.bottomAnchor.constraint(equalTo: self.bottomAnchor),

        titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
        titleLabel.leadingAnchor.constraint(equalTo: slider.leadingAnchor)
      ])

      slider.addTarget(self, action: #selector(handleValueChange(_ :)), for: .valueChanged)
    }
  }

  // MARK: - Selectors
  @objc private func handleValueChange(_ sender: UISlider) {
    gramLabel.text = "\(Int(sender.value))g"
  }
}
