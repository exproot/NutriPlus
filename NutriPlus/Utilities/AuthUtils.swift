//
//  AuthUtils.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 28.12.2024.
//

import Foundation
import FirebaseAuth

final class AuthUtils {
  static let shared = AuthUtils()

  private init() { }

  func getCurrentUserUid() -> String {
    return Auth.auth().currentUser?.uid ?? ""
  }
}
