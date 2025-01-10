//
//  CalorieGoalCellVM.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 2.01.2025.
//

import Foundation

struct CalorieGoalCellViewModel: Hashable {
  let title: String
  let progressValue: CGFloat

  init(title: String, progressValue: CGFloat) {
    self.title = title
    self.progressValue = progressValue
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(title)
    hasher.combine(progressValue)
  }

  static func ==(lhs: CalorieGoalCellViewModel, rhs: CalorieGoalCellViewModel) -> Bool {
    return lhs.title == rhs.title && lhs.progressValue == rhs.progressValue
  }
}
