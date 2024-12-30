//
//  BMRCalculationStrategy.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 29.12.2024.
//

import Foundation

protocol BMRCalculationStrategy {
  func calculateBMR(weight: Double, height: Double, age: Double, gender: Bool) -> Double
}
