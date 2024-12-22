//
//  CameraViewController+CameraService.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 22.12.2024.
//

import UIKit

// MARK: - CameraServiceDelegate
extension CameraViewController: CameraServiceDelegate {
  func cameraService(didCaptureImage image: UIImage?) {
    guard let image = image, let data = image.jpegData(compressionQuality: 0.1) else { return }

    viewModel.stopCameraSession()
    viewModel.fetchMealFromGemini(with: data)
  }

  func cameraService(didFailWithError error: any Error) {
    barScannerAnimation.stop()
    print(error)
  }

  func cameraServiceDidStartCapturingPhoto(_ cameraService: CameraService) { }
}
