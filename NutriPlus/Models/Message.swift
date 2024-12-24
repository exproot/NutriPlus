//
//  Message.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 23.12.2024.
//

import Foundation

struct Message: Hashable {
  let id: String
  let text: String
  let isSentByUser: Bool

  init(id: String = UUID().uuidString, text: String, isSentByUser: Bool) {
    self.id = id
    self.text = text
    self.isSentByUser = isSentByUser
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}
