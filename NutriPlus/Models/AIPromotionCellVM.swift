//
//  AIPromotionCellVM.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 2.01.2025.
//

import Foundation

struct AIPromotionCellViewModel: Hashable {
  let id: String
  let title: String

  init(id: String = UUID().uuidString, title: String) {
    self.id = id
    self.title = title
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}
