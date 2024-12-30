//
//  DatabaseServiceProtocol.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 28.12.2024.
//

import Foundation
import FirebaseFirestore

protocol DatabaseServiceProtocol {
  func getDocuments(for collectionReference: CollectionReference, completion: @escaping (Result<[DocumentSnapshot], Error>) -> Void)
  func getDocument<T: Codable>(for documentReference: DocumentReference, completion: @escaping (Result<T, Error>) -> Void)
  func setData(for documentReference: DocumentReference, data: [String: Any], completion: @escaping (Error?) -> Void)
  func updateData(for documentReference: DocumentReference, data: [String: Any], completion: @escaping (Error?) -> Void)
  func deleteDocument(for documentReference: DocumentReference, completion: @escaping (Error?) -> Void)
}
