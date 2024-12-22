//
//  CameraService.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 22.12.2024.
//

import AVFoundation
import UIKit

enum CameraError: Error, LocalizedError {
  case deviceUnavailable
  case unableToAddInput

  var errorDescription: String? {
    switch self {
    case .deviceUnavailable:
      return "No suitable camera device available."
    case .unableToAddInput:
      return "Unable to add the camera input to the session."
    }
  }
}

final class CameraService: NSObject {
  private var cameraSession: CameraSessionProtocol
  weak var delegate: CameraServiceDelegate?

  init(cameraSession: CameraSessionProtocol) {
    self.cameraSession = cameraSession
  }

  func start() {
    CameraPermissionsManager.checkPermissions { [weak self] result in
      guard let self = self else { return }

      switch result {
      case .success:
        self.cameraSession.startSession()
      case .failure(let error):
        self.delegate?.cameraService(didFailWithError: error)
      }
    }
  }

  func stop() {
    cameraSession.stopSession()
  }

  func capturePhoto() {
    delegate?.cameraServiceDidStartCapturingPhoto(self)
    cameraSession.capturePhoto(delegate: self)
  }

  func setupPreviewLayer(for view: UIView) {
    cameraSession.setupPreviewLayer(for: view)
  }
}

// MARK: - AVCapturePhotoCaptureDelegate
extension CameraService: AVCapturePhotoCaptureDelegate {
  func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: (any Error)?) {
    if let error = error {
      self.delegate?.cameraService(didFailWithError: error)
      return
    }

    if
      let imageData = photo.fileDataRepresentation(),
      let image = UIImage(data: imageData) {

      delegate?.cameraService(didCaptureImage: image)
    }
  }
}
