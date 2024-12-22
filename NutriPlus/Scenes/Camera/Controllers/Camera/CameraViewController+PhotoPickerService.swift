//
//  CameraViewController+PhotoPickerService.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 22.12.2024.
//

import UIKit

// MARK: - PhotoPickerServiceDelegate
extension CameraViewController: PhotoPickerServiceDelegate {
  func photoPickerService(_ photoPickerService: PhotoPickerService, didSelectImage image: UIImage?) {
    guard let image = image, let data = image.jpegData(compressionQuality: 0.1) else { return }

    setupImagePreviewView(with: image)
    viewModel.takePhotoButtonEnabled = true
    viewModel.fetchMealFromGemini(with: data)
  }
  
  func photoPickerService(_ photoPickerService: PhotoPickerService, didFailWithError error: any Error) {
    viewModel.takePhotoButtonEnabled = true

    self.showAlert(
      title: "Error",
      message: "\(error.localizedDescription)"
    )
  }
  
  func photoPickerServiceDidCancel(_ photoPickerService: PhotoPickerService) {
    viewModel.takePhotoButtonEnabled = true
    barScannerAnimation.isHidden = false
  }
}
