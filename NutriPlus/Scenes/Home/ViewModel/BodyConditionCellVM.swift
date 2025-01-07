//
//  BodyConditionCellVM.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 2.01.2025.
//

import UIKit

struct ConditionCellViewModel: Hashable {
  let id: String
  let title: String
  let colors: [UIColor]

  init(id: String = UUID().uuidString, title: String, colors: [UIColor]) {
    self.id = id
    self.title = title
    self.colors = colors
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}
