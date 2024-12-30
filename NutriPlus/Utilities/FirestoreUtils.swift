//
//  FirestoreUtils.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 28.12.2024.
//

import Foundation
import FirebaseFirestore

final class FirestoreUtils {
  static let shared = FirestoreUtils()

  private let db = Firestore.firestore()

  private init() {}

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
}
