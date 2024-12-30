//
//  FirestoreDatabaseService.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 28.12.2024.
//

import Foundation
import FirebaseFirestore

final class FirestoreDatabaseService: DatabaseServiceProtocol {
  private let db = Firestore.firestore()

  func getDocuments(for collectionReference: CollectionReference, completion: @escaping (Result<[DocumentSnapshot], any Error>) -> Void) {
    collectionReference.getDocuments { snapshot, error in
      if let error = error {
        completion(.failure(error))
      } else if let snapshot = snapshot {
        completion(.success(snapshot.documents))
      } else {
        completion(.failure(NSError(domain: "FirestoreError", code: 404, userInfo: [NSLocalizedDescriptionKey: "No documents found"])))
      }
    }
  }

  func getDocument<T>(for documentReference: DocumentReference, completion: @escaping (Result<T, any Error>) -> Void) where T : Decodable, T : Encodable {
    documentReference.getDocument { snapshot, error in
      if let error = error {
        completion(.failure(error))
      } else if let snapshot = snapshot, snapshot.exists, let data = snapshot.data() {
        do {
          let decoded = try Firestore.Decoder().decode(T.self, from: data)
          completion(.success(decoded))
        } catch {
          completion(.failure(error))
        }
      } else {
        completion(.failure(NSError(domain: "FirestoreError", code: 404, userInfo: [NSLocalizedDescriptionKey: "Document not found"])))
      }
    }
  }

  func setData(for documentReference: DocumentReference, data: [String : Any], completion: @escaping ((any Error)?) -> Void) {
    documentReference.setData(data) { error in
      completion(error)
    }
  }

  func updateData(for documentReference: DocumentReference, data: [String : Any], completion: @escaping ((any Error)?) -> Void) {
    documentReference.updateData(data) { error in
      completion(error)
    }
  }

  func deleteDocument(for documentReference: DocumentReference, completion: @escaping ((any Error)?) -> Void) {
    documentReference.delete { error in
      completion(error)
    }
  }
}
