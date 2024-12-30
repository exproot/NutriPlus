//
//  CustomSegmentedControl.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 30.12.2024.
//

import UIKit

final class CustomSegmentedControl: UISegmentedControl {
  /// Custom Segmented Control
  /// - Parameters:
  ///   - items: Items.
  ///   - backgroundColor: Segmented control's background color, defaults to systemBackground.
  ///   - selectedColor: Segmented control's color for selected state, defaults to systemBackground.
  ///   - textColor: Segmented control's text color for normal state, defaults to label.
  ///   - selectedTextColor: Segmented control's text color for selected state, defaults to label.
  init(items: [String], backgroundColor: UIColor = .systemBackground, selectedColor: UIColor = .systemBackground, textColor: UIColor = .label, selectedTextColor: UIColor = .label) {
    super.init(items: items)
    self.selectedSegmentIndex = 0
    self.backgroundColor = backgroundColor
    self.selectedSegmentTintColor = selectedColor
    self.setTitleTextAttributes([.foregroundColor: textColor], for: .normal)
    self.setTitleTextAttributes([.foregroundColor: selectedTextColor], for: .selected)
    self.clipsToBounds = true
    translatesAutoresizingMaskIntoConstraints = false
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
