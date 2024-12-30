//
//  AssessmentModel.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 24.10.2024.
//

import Foundation

struct AssessmentModel: Codable {
  var age: Int?
  var weight: Int?
  var height: Int?
  var fitLevel: Int?
  var gender: Bool?
  var goal: String?

  var heightInMeters: Double? {
    guard let height = height else { return nil }
    return Double(height) / 100
  }
}
