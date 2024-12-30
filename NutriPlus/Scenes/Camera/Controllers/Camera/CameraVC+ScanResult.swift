//
//  CameraViewController+ScanResult.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 22.12.2024.
//

import Foundation

// MARK: - ScanResultControllerDelegate
extension CameraViewController: ScanResultControllerDelegate {
  func scanResultController(_ controller: ScanResultViewController, didConfirmMeal meal: Meal) {
    delegate?.didScanMealWithAI(self, meal: meal)
    navigationController?.popViewController(animated: true)
  }
  
  func scanResultControllerDidCancel(_ controller: ScanResultViewController) {
    viewModel.takePhotoButtonIsEnabled = true
    viewModel.startCameraSession()
    barScannerAnimation.isHidden = false

    if let photoPreviewView {
      photoPreviewView.removeFromSuperview()
    }
  }
}

extension CameraViewController {
  func presentScanResultController(with meal: Meal) {
    let scanResultVC = ScanResultViewController(meal: meal)
    scanResultVC.delegate = self
    scanResultVC.isModalInPresentation = true

    if let sheet = scanResultVC.sheetPresentationController {
      sheet.detents = [.medium()]
    }

    navigationController?.present(scanResultVC, animated: true)
  }
}
