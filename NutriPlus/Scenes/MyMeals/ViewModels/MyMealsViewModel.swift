//
//  MyMealsViewModel.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 7.11.2024.
//

import Foundation

protocol MyMealsViewModelProtocol {
    func viewDidLoad()
}

final class MyMealsViewModel {
    var selectedDateIndex: Int = 0
    var dates: [(day: String, month: String)] = []
    var testCalendarItems: [Row] = []
    var testMealItems: [Row] = []
    
    private func getDays() {
        let anchor = Date()
        let calendar = Calendar.current
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM"
        
        for i in -7...7 {
            if let date = calendar.date(byAdding: .day, value: i, to: anchor) {
                let date = dateFormatter.string(from: date)
                let dayAndMonth = date.components(separatedBy: "-")
                dates.append((day: dayAndMonth[0], month: dayAndMonth[1]))
            }
        }
    }
    
    private func prepareCalendar() {
        dates.forEach { dayAndMonth in
            testCalendarItems.append(.calendar(CalendarCellViewModel(with: dayAndMonth)))
        }
    }
    
    func prepareTestMeals(for day: String?) {
        if day == "07" {
            testMealItems = [
                .meal(MealCellViewModel()),
                .meal(MealCellViewModel()),
                .meal(MealCellViewModel())
            ]
        } else {
            _ = testMealItems.popLast()
        }
    }
    
    func setIndexToCurrentDay() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        
        let currentDay = dateFormatter.string(from: Date())
        
        for (index, element) in dates.enumerated() {
            if currentDay == element.day {
                selectedDateIndex = index
            }
        }
    }
}

extension MyMealsViewModel {
    enum Section {
        case main
        case meals
    }
    
    enum Row: Hashable {
        case calendar(CalendarCellViewModel)
        case meal(MealCellViewModel)
    }
}

extension MyMealsViewModel: MyMealsViewModelProtocol {
    func viewDidLoad() {
        getDays()
        prepareCalendar()
        setIndexToCurrentDay()
    }
}
