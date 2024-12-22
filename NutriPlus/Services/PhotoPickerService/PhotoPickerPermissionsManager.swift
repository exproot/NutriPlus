//
//  PhotoPickerPermissionsManager.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 22.12.2024.
//

import Photos

enum LibraryPermissionError: Error, LocalizedError {
  case denied
  case unknown

  var errorDescription: String? {
    switch self {
    case .denied:
      return "Access to the photo library is denied."
    case .unknown:
      return "An unknown error occurred."
    }
  }
}

enum PhotoPickerPermissionsManager {
  static func checkPermissions(completion: @escaping (Result<Void, Error>) -> Void) {
    switch PHPhotoLibrary.authorizationStatus(for: .readWrite) {
    case .notDetermined:
      PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
        if status == .authorized || status == .limited {
          completion(.success(()))
        } else {
          completion(.failure(LibraryPermissionError.denied))
        }
      }
    case .restricted:
      completion(.failure(LibraryPermissionError.denied))
    case .denied:
      completion(.failure(LibraryPermissionError.denied))
    case .authorized:
      completion(.success(()))
    case .limited:
      // TODO: - Handle Limited Access
      completion(.success(()))
    @unknown default:
      completion(.failure(LibraryPermissionError.unknown))
    }
  }
}
