//
//  CameraPermissionsManager.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 22.12.2024.
//

import AVFoundation

enum CameraPermissionError: Error {
  case denied
  case unknown
}

enum CameraPermissionsManager {
  static func checkPermissions(completion: @escaping (Result<Void, Error>) -> Void) {
    switch AVCaptureDevice.authorizationStatus(for: .video) {
    case .notDetermined:
      AVCaptureDevice.requestAccess(for: .video) { granted in
        if granted {
          completion(.success(()))
        } else {
          completion(.failure(CameraPermissionError.denied))
        }
      }
    case .restricted:
      completion(.failure(CameraPermissionError.denied))
    case .denied:
      completion(.failure(CameraPermissionError.denied))
    case .authorized:
      completion(.success(()))
    @unknown default:
      completion(.failure(CameraPermissionError.unknown))
    }
  }
}
