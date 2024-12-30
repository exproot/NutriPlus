//
//  MealService.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 21.12.2024.
//

import FirebaseFirestore

final class MealService {
  private let databaseService: DatabaseServiceProtocol
  private let userRef: DocumentReference

  init(databaseService: DatabaseServiceProtocol = FirestoreDatabaseService(), uid: String) {
    self.databaseService = databaseService
    self.userRef = Firestore.firestore().collection("users").document(uid)
  }

  func fetchMeals(dateString: String, completion: @escaping (Result<[MealCellViewModel], Error>) -> Void) {
    let mealRef = userRef.collection("meals").document(dateString).collection("mealItems")

    databaseService.getDocuments(for: mealRef) { result in
      switch result {
      case .success(let documents):
        var meals: [MealCellViewModel] = []

        for document in documents {
          let data = document.data()

          if let name = data?["name"] as? String,
             let detail = data?["detail"] as? String,
             let type = data?["type"] as? String,
             let calories = data?["calories"] as? Int,
             let protein = data?["protein"] as? Int,
             let carbs = data?["carbs"] as? Int,
             let fat = data?["fat"] as? Int {

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
        completion(.success(meals))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }

  func addMeal(meal: MealCellViewModel, dateString: String, completion: @escaping (Result<Bool, Error>) -> Void) {
    let mealData: [String: Any] = [
      "name": meal.name,
      "detail": meal.detail,
      "type": meal.type,
      "calories": meal.calories,
      "protein": meal.protein,
      "carbs": meal.carbs,
      "fat": meal.fat
    ]

    let mealRef = userRef.collection("meals").document(dateString).collection("mealItems").document(meal.id)

    databaseService.setData(for: mealRef, data: mealData) { error in
      if let error = error {
        completion(.failure(error))
      } else {
        completion(.success(true))
      }
    }
  }

  func deleteMeal(mealId: String, dateString: String, completion: @escaping (Result<Bool, Error>) -> Void) {
    let mealRef = userRef.collection("meals").document(dateString).collection("mealItems").document(mealId)

    databaseService.deleteDocument(for: mealRef) { error in
      if let error = error {
        completion(.failure(error))
      } else {
        completion(.success(true))
      }
    }
  }
}
