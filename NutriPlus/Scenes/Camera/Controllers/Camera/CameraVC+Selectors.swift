//
//  CameraViewController+Selectors.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 22.12.2024.
//

import UIKit

// MARK: - Selectors
extension CameraViewController {
  @objc func handleCancelButton(_ sender: UIButton) {
    navigationController?.popViewController(animated: true)
    delegate?.didCancelCapturing(self)
  }

  @objc func handleGalleryButton(_ sender: UIButton) {
    viewModel.takePhotoButtonIsEnabled = false
    viewModel.photoPickerService.present(on: self)
  }

  @objc func handleCaptureImage() {
    #if targetEnvironment(simulator)
    self.showAlert(
      title: "Running on Simulator",
      message: "App is running on a simulator therefore can't access the camera."
    )
    #else
    viewModel.takePhotoButtonIsEnabled = false
    viewModel.capturePhoto()
    #endif
  }
}

extension CameraViewController {
  func setupActions() {
    cancelButton.addTarget(self, action: #selector(handleCancelButton(_ :)), for: .touchUpInside)
    galleryButton.addTarget(self, action: #selector(handleGalleryButton(_ :)), for: .touchUpInside)
    takePhotoButton.addTarget(self, action: #selector(handleCaptureImage), for: .touchUpInside)
  }
}
