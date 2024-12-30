//
//  AgeSelectionViewModel.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 26.12.2024.
//

import Foundation

final class AgeSelectionViewModel {
  @Published var selectedAge: Int = 18

  let ages = Array(1...100)

  var selectedAgeText: String {
    "\(selectedAge)"
  }

  func selectAge(at index: Int) {
    guard index >= 0 && index < ages.count else { return }
    selectedAge = ages[index]
  }
}
