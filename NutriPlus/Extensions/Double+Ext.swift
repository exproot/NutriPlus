//
//  Double+Ext.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 29.12.2024.
//

import Foundation

extension Double {
  var formatted: String {
    return String(format: "%.0f", self)
  }

  func roundToOneDecimal() -> Double {
    ((self * 10).rounded() / 10)
  }
}
