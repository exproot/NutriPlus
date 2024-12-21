//
//  FireStoreService.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 24.10.2024.
//

import Foundation
import FirebaseFirestore

final class FireStoreService {
  static let shared = FireStoreService()

  private let db = Firestore.firestore()
  
  private init() {}

  func setAssessment(for uid: String) {
    db.collection("users").document(uid).updateData([
      "assessment_done": true
    ]) { error in
      if let error = error {
        print(error)
      }
    }
  }

  func checkFirstLogin(for uid: String, completion: @escaping (Bool?) -> Void) {
    db.collection("users").document(uid).getDocument { snapshot, error in
      if let error = error {
        print(error)
        completion(nil)
        return
      }

      guard let data = snapshot?.data() else { return }

      if let assessmentDone = data["assessment_done"] as? Bool {
        completion(assessmentDone)
      } else {
        completion(nil)
      }
    }
  }

  func saveUserToFirestore(with uid: String, completion: @escaping (Error?) -> Void) {
    db.collection("users").document(uid)
      .setData([
        "assessment_done": false
      ]) { error in
        completion(error)
      }

    completion(nil)
  }
}
