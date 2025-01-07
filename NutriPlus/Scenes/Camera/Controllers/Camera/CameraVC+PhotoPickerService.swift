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
    viewModel.takePhotoButtonIsEnabled = true
    viewModel.fetchMealFromGemini(with: data)
  }
  
  func photoPickerService(_ photoPickerService: PhotoPickerService, didFailWithError error: any Error) {
    viewModel.takePhotoButtonIsEnabled = true

    self.showAlert(
      title: "Error",
      message: "\(error.localizedDescription)"
    )
  }
  
  func photoPickerServiceDidCancel(_ photoPickerService: PhotoPickerService) {
    viewModel.takePhotoButtonIsEnabled = true
    barScannerAnimation.isHidden = false
  }
}

extension CameraViewController {
  func setupImagePreviewView(with image: UIImage?) {
    photoPreviewView = PhotoPreviewView(frame: captureCoverView.frame)

    if let photoPreviewView {
      photoPreviewView.imageView.image = image
      view.insertSubview(photoPreviewView, belowSubview: barScannerAnimation)
    }
  }

  func removeImagePreview() {
    if let photoPreviewView {
      photoPreviewView.removeFromSuperview()
    }
  }
}
