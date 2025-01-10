//
//  SettingsSection.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 10.01.2025.
//

import Foundation

enum SettingsSection: Int, CaseIterable {
  case account, personal, logout

  var sectionHeaderText: String? {
    switch self {
    case .account:
      return "Account"
    case .personal:
      return "Personal Information"
    case .logout:
      return nil
    }
  }
}
