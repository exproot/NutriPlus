//
//  GenderSelectionViewModel.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 26.12.2024.
//

import Foundation

enum Gender {
  case male, female, none
}

final class GenderSelectionViewModel {
  @Published var selectedGender: Gender = .none
  @Published var isContinueButtonEnabled = false

  func selectGender(_ gender: Gender) {
    guard selectedGender != gender else { return }

    selectedGender = gender
    isContinueButtonEnabled = gender != .none
  }
}
