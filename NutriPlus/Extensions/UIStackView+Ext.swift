//
//  UIStackView+Ext.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 20.12.2024.
//

import UIKit

extension UIStackView {
  func extractSliderValues() -> [Int] {
    arrangedSubviews
      .compactMap { $0 as? MacroSliderView }
      .compactMap { $0.slider?.value}
      .map { Int($0) }
  }
}
