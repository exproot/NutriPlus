//
//  CalendarCellViewModel.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 7.11.2024.
//

import Foundation

struct CalendarCellViewModel: Hashable {
    var uid = UUID().uuidString
    let day: String
    let month: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(uid)
    }
    
    init(with dayAndMonth: (day: String, month: String)) {
        self.day = dayAndMonth.day
        self.month = dayAndMonth.month
    }
}
