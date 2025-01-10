//
//  CalendarCellViewModel.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 7.11.2024.
//

import Foundation

struct CalendarCellViewModel: Hashable {
  var uid = UUID().uuidString
  let dateString: String

  func hash(into hasher: inout Hasher) {
    hasher.combine(uid)
  }

  init(dateString: String) {
    self.dateString = dateString
  }
}
