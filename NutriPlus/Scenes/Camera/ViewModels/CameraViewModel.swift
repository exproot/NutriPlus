//
//  CameraViewModel.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 22.12.2024.
//

import Foundation

final class CameraViewModel {
  // MARK: - Properties
  let cameraService: CameraService
  let photoPickerService: PhotoPickerService
  let geminiService: GeminiService

  // MARK: - Published Properties
  @Published var takePhotoButtonIsEnabled = true

  // MARK: - Lifecycle
  init(cameraService: CameraService, photoPickerService: PhotoPickerService, geminiService: GeminiService) {
    self.cameraService = cameraService
    self.photoPickerService = photoPickerService
    self.geminiService = geminiService
  }

  // MARK: - CameraService Methods
  func capturePhoto() {
    cameraService.capturePhoto()
  }

  func startCameraSession() {
    cameraService.start()
  }

  func stopCameraSession() {
    cameraService.stop()
  }

  // MARK: - GeminiService Methods
  func fetchMealFromGemini(with imageData: Data?) {
    guard let imageData = imageData else { return }

    geminiService.getResponse(for: imageData)
  }
}
