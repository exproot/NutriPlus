//
//  MyMealsViewController+Selectors.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 21.12.2024.
//

import UIKit

// MARK: - TabBarButtonsDelegate
extension MyMealsViewController: TabBarButtonsDelegate {
  func didTapCameraOption() {
    guard viewModel.isSelectedDateToday() else {
      showAlert(title: "Nutri Plus", message: "You can add meals only to the current day!")
      return
    }
    let camController = CameraViewController()
    camController.delegate = self
    navigationController?.pushViewController(camController, animated: true)
  }
  
  func didTapManualOption() {
    guard viewModel.isSelectedDateToday() else {
      showAlert(title: "Nutri Plus", message: "You can add meals only to the current day!")
      return
    }
    let addMealController = AddMealManuallyViewController()
    addMealController.delegate = self
    present(addMealController, animated: true)
  }
}
