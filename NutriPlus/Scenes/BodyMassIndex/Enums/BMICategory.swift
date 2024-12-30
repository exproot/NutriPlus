//
//  BMICategory.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 30.12.2024.
//

import UIKit

enum BMICategory {
  case underweight, normal, overweight, obese

  var description: String {
    switch self {
    case .underweight:
      return "You are underweight. Consider a balanced diet."
    case .normal:
      return "You have a healthy body weight 🎉"
    case .overweight:
      return "You are overweight. Regular exercise is recommended."
    case .obese:
      return "You are obese. Consult a healthcare provider."
    }
  }

  var colors: [UIColor] {
    switch self {
    case .underweight:
      return [UIColor.systemBlue, UIColor.cyan]
    case .normal:
      return [UIColor.systemGreen, UIColor.systemTeal]
    case .overweight:
      return [UIColor.systemYellow, UIColor.systemOrange]
    case .obese:
      return [UIColor.systemRed, UIColor.systemPink]
    }
  }
}
