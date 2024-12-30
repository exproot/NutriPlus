//
//  AddNewMealVC+CameraVCDelegate.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 30.12.2024.
//

import Foundation

// MARK: - CameraViewControllerDelegate
extension AddNewMealViewController: CameraViewControllerDelegate {
  func didScanMealWithAI(_ controller: CameraViewController, meal: Meal) {
    delegate?.addNewMealController(didAddWithAI: meal)
    navigationController?.popViewController(animated: true)
  }

  func didCancelCapturing(_ controller: CameraViewController) {
    headerView.segmentedControl.selectedSegmentIndex = 0
  }
}
