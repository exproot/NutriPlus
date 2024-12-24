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
      print(error)
    }
  }
  
  func geminiService(didFailWithError error: any Error) {
    print(error)
    DispatchQueue.main.async { [weak self] in
      self?.viewModel.takePhotoButtonEnabled = true
      self?.barScannerAnimation.stop()
      self?.barScannerAnimation.isHidden = true
    }
  }
  
  func geminiServiceDidStartGeneratingResponse(_ geminiService: GeminiService) {
    viewModel.takePhotoButtonEnabled = false
    barScannerAnimation.isHidden = false
    barScannerAnimation.play()
  }
}
