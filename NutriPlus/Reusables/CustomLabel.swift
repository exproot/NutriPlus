//
//  CustomLabel.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 18.12.2024.
//

import UIKit

final class CustomLabel: UILabel {
  init(
    text: String,
    fontSize: CGFloat,
    fontWeight: UIFont.Weight,
    textColor: UIColor,
    alignment: NSTextAlignment = .natural,
    numberOfLines: Int = 1
  ) {
    super.init(frame: .zero)
    self.text = text
    self.numberOfLines = numberOfLines
    self.textAlignment = alignment
    self.font = .systemFont(ofSize: fontSize, weight: fontWeight)
    self.textColor = textColor
    translatesAutoresizingMaskIntoConstraints = false
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
