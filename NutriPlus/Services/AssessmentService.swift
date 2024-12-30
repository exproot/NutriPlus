//
//  AssessmentService.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 26.12.2024.
//

import Foundation
import FirebaseFirestore

enum AssessmentServiceError: Error {
  case userNotFound
  case assessmentDataNotFound
  case firestoreError(Error)
}

protocol AssessmentServiceProtocol {
  func fetchAssessmentData(completion: @escaping (Result<AssessmentModel, AssessmentServiceError>) -> Void)
  func saveAssessmentData(_ assessmentModel: AssessmentModel, completion: @escaping (Result<Bool, AssessmentServiceError>) -> Void)
  func updateAssessmentState(to state: Bool, completion: @escaping (Result<Bool, AssessmentServiceError>) -> Void)
}

final class AssessmentService: AssessmentServiceProtocol {
  private let databaseService: DatabaseServiceProtocol
  private let userRef: DocumentReference

  init(databaseService: DatabaseServiceProtocol = FirestoreDatabaseService(), uid: String) {
    self.databaseService = databaseService
    self.userRef = Firestore.firestore().collection("users").document(uid)
  }

  func fetchAssessmentData(completion: @escaping (Result<AssessmentModel, AssessmentServiceError>) -> Void) {
    let assessmentRef = userRef.collection("assessments").document("assessmentData")

    databaseService.getDocument(for: assessmentRef) { (result: Result<AssessmentModel, Error>) in
      switch result {
      case .success(let assessment):
        completion(.success(assessment))
      case .failure:
        completion(.failure(.assessmentDataNotFound))
      }
    }
  }

  func saveAssessmentData(_ assessmentModel: AssessmentModel, completion: @escaping (Result<Bool, AssessmentServiceError>) -> Void) {
    let assessmentRef = userRef.collection("assessments").document("assessmentData")

    let assessmentData: [String: Any] = [
      "age": assessmentModel.age ?? 0,
      "weight": assessmentModel.weight ?? 0,
      "height": assessmentModel.height ?? 0,
      "fitLevel": assessmentModel.fitLevel ?? 0,
      "gender": assessmentModel.gender ?? true,
      "goal": assessmentModel.goal ?? ""
    ]

    databaseService.setData(for: assessmentRef, data: assessmentData) { [weak self] error in
      if let error = error {
        completion(.failure(.firestoreError(error)))
      } else {
        self?.updateAssessmentState(to: true, completion: { result in
          switch result {
          case .success:
            completion(.success(true))
          case .failure(let error):
            completion(.failure(error))
          }
        })
      }
    }
  }

  func updateAssessmentState(to state: Bool, completion: @escaping (Result<Bool, AssessmentServiceError>) -> Void) {
    let data = ["assessment_done": state]

    databaseService.updateData(for: userRef, data: data) { error in
      if let error = error {
        completion(.failure(.firestoreError(error)))
      } else {
        completion(.success(true))
      }
    }
  }
}
