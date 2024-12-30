//
//  AuthServiceProtocol.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 28.12.2024.
//

import Foundation
import FirebaseAuth

protocol AuthServiceProtocol {
  func signOut(completion: @escaping (Error?) -> Void)
  func signIn(with email: String, and password: String, completion: @escaping (Result<User, Error>) -> Void)
  func signUp(with email: String, and password: String, completion: @escaping (Result<User, Error>) -> Void)
}
