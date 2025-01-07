//
//  CameraViewController+GeminiService.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 22.12.2024.
//

import Foundation

// MARK: - GeminiServiceDelegate
extension CameraViewController: GeminiImageDelegate {
  func geminiService(didGenerateResponse data: Data?) {
    guard let data = data else { return }

    do {
      let meal = try JSONDecoder().decode(Meal.self, from: data)
      DispatchQueue.main.async { [weak self] in
        self?.barScannerAnimation.stop()
        self?.barScannerAnimation.isHidden = true
        self?.presentScanResultController(with: meal)
      }
    } catch {
      DispatchQueue.main.async { [weak self] in
        guard let self = self else { return }
        self.removeImagePreview()
        self.viewModel.startCameraSession()
        self.barScannerAnimation.stop()
        self.barScannerAnimation.isHidden = false
        self.viewModel.takePhotoButtonIsEnabled = true
        self.showAlert(title: "Scan Failed", message: "Couldn't identify anything, please make sure your meal visible to the camera.")
      }
    }
  }
  
  func geminiService(didFailWithError error: any Error) {
    print(error)
    DispatchQueue.main.async { [weak self] in
      self?.viewModel.takePhotoButtonIsEnabled = true
      self?.barScannerAnimation.stop()
      self?.barScannerAnimation.isHidden = true
    }
  }
  
  func geminiServiceDidStartGeneratingResponse(_ geminiService: GeminiService) {
    viewModel.takePhotoButtonIsEnabled = false
    barScannerAnimation.isHidden = false
    barScannerAnimation.play()
  }
}
