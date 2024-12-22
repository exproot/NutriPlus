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

  // MARK: - Published Properties
  @Published var takePhotoButtonEnabled = true

  // MARK: - Lifecycle
  init(cameraService: CameraService, photoPickerService: PhotoPickerService) {
    self.cameraService = cameraService
    self.photoPickerService = photoPickerService
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
}
