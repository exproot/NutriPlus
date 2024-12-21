//
//  MyMealsViewModel.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 7.11.2024.
//

import Foundation
import FirebaseAuth

final class MyMealsViewModel {
  private let mealService: MealServiceProtocol
  var selectedIndex: Int? = nil
  var dateItems: [CalendarCellViewModel] = []
  var mealItems: [MealCellViewModel] = []

  private lazy var calendar: Calendar = .current
  private lazy var dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter
  }()

  init(mealService: MealServiceProtocol) {
    self.mealService = mealService
    generateDates()
  }

  func generateDates() {
    let anchor = Date()
    var dates: [CalendarCellViewModel] = []

    for offset in -7...7 {
      if let date = calendar.date(byAdding: .day, value: offset, to: anchor) {
        let dateString = dateFormatter.string(from: date)
        dates.append(CalendarCellViewModel(dateString: dateString))

        if dateFormatter.string(from: date) == dateFormatter.string(from: Date()) {
          selectedIndex = dates.count - 1
        }
      }
    }

    dateItems = dates
  }

  func isSelectedDateToday() -> Bool {
    guard 
      let selectedDateIndex = selectedIndex, selectedDateIndex >= 0 && selectedDateIndex < dateItems.count
    else {
      return false
    }

    let selectedDateString = dateItems[selectedDateIndex].dateString
    let currentDateString = dateFormatter.string(from: Date())

    return selectedDateString == currentDateString
  }

  func fetchMeals(for date: String, completion: @escaping () -> Void) {
    guard let uid = Auth.auth().currentUser?.uid else {
      print("User is not logged in.")
      return
    }

    mealService.fetchMeals(dateString: date, uid: uid) { [weak self] meals in
      self?.mealItems = meals
      completion()
    }
  }

  func addMeal(meal: MealCellViewModel, date: String, completion: @escaping () -> Void) {
    guard let uid = Auth.auth().currentUser?.uid else {
      print("User is not logged in.")
      return
    }

    mealService.addMeal(meal: meal, dateString: date, uid: uid) { [weak self] success in
      if success {
        self?.fetchMeals(for: date) {
          completion()
        }
      }
    }
  }

  func deleteMeal(mealId: String, dateString: String, completion: @escaping () -> Void) {
    guard let uid = Auth.auth().currentUser?.uid else {
      print("User is not logged in.")
      return
    }

    mealService.deleteMeal(mealId: mealId, dateString: dateString, uid: uid) { [weak self] success in
      if success {
        self?.fetchMeals(for: dateString) {
          completion()
        }
      }
    }
  }
}
