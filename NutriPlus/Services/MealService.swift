//
//  MealService.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 21.12.2024.
//

import FirebaseFirestore

protocol MealServiceProtocol {
  func fetchMeals(dateString: String, uid: String, completion: @escaping ([MealCellViewModel]) -> Void)
  func addMeal(meal: MealCellViewModel, dateString: String, uid: String, completion: @escaping (Bool) -> Void)
  func deleteMeal(mealId: String, dateString: String, uid: String, completion: @escaping (Bool) -> Void)
}

final class MealService: MealServiceProtocol {
  private let db = Firestore.firestore()

  func deleteMeal(mealId: String, dateString: String, uid: String, completion: @escaping (Bool) -> Void) {
    let mealRef = db.collection("users").document(uid).collection("meals").document(dateString)
      .collection("mealItems").document(mealId)

    mealRef.delete { error in
      if let error = error {
        print("Error fetching meals: \(error.localizedDescription)")
        completion(false)
        return
      }

      completion(true)
    }
  }

  func fetchMeals(dateString: String, uid: String, completion: @escaping ([MealCellViewModel]) -> Void) {
    db.collection("users").document(uid).collection("meals").document(dateString).collection("mealItems").getDocuments { snapshot, error in
      if let error = error {
        print("Error fetching meals: \(error.localizedDescription)")
        completion([])
        return
      }

      var meals: [MealCellViewModel] = []

      guard let snapshot = snapshot else {
        completion([])
        return
      }

      for document in snapshot.documents {
        let data = document.data()

        if let name = data["name"] as? String,
           let detail = data["detail"] as? String,
           let type = data["type"] as? String,
           let calories = data["calories"] as? Int,
           let protein = data["protein"] as? Int,
           let carbs = data["carbs"] as? Int,
           let fat = data["fat"] as? Int {

          let meal = MealCellViewModel(
            id: document.documentID,
            name: name,
            detail: detail,
            type: type,
            calories: calories,
            protein: protein,
            carbs: carbs,
            fat: fat
          )
          meals.append(meal)
        }
      }

      completion(meals)
    }
  }

  func addMeal(meal: MealCellViewModel, dateString: String, uid: String, completion: @escaping (Bool) -> Void) {
    let mealData: [String: Any] = [
      "name": meal.name,
      "detail": meal.detail,
      "type": meal.type,
      "calories": meal.calories,
      "protein": meal.protein,
      "carbs": meal.carbs,
      "fat": meal.fat
    ]

    let mealRef = db.collection("users").document(uid).collection("meals").document(dateString)
      .collection("mealItems").document(meal.id)

    mealRef.setData(mealData) { error in
      if let error = error {
        print(error)
        completion(false)
      } else {
        completion(true)
      }
    }
  }
}
