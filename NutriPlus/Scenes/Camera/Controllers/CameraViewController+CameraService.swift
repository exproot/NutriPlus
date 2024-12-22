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
    guard let image = image else { return }

    viewModel.stopCameraSession()
  }

  func cameraService(didFailWithError error: any Error) {
    print(error)
  }

  func cameraServiceDidStartCapturingPhoto(_ cameraService: CameraService) { }
}
