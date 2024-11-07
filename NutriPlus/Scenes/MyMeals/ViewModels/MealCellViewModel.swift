//
//  MealCellViewModel.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 7.11.2024.
//

import Foundation

struct MealCellViewModel: Hashable {
    var uid = UUID().uuidString
    let text: String = "294 kcal - 100g"
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(uid)
    }
}
