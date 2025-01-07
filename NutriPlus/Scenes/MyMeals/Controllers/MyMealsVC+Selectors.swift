//
//  MyMealsViewController+Selectors.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 21.12.2024.
//

import UIKit

// MARK: - Selectors
extension MyMealsViewController {
  @objc func cameraOptionButtonTapped() {
    guard viewModel.isSelectedDateToday() else {
      showAlert(title: "Nutri Plus", message: "You can add meals only to the current day!")
      return
    }
    let camController = CameraViewController()
    camController.delegate = self
    navigationController?.pushViewController(camController, animated: true)
  }

  @objc func manualOptionButtonTapped() {
    guard viewModel.isSelectedDateToday() else {
      showAlert(title: "Nutri Plus", message: "You can add meals only to the current day!")
      return
    }
    let addMealController = AddMealManuallyViewController()
    addMealController.delegate = self
    addMealController.isModalInPresentation = true
    present(addMealController, animated: true)
  }

  @objc func plusButtonTapped(_ sender: UIButton) {
    if buttonsVisible == false {
      sender.transform = CGAffineTransform(rotationAngle: .pi / 4)
      buttonsVisible.toggle()
    } else {
      UIView.animate(withDuration: 0.3) {
        sender.transform = CGAffineTransform(rotationAngle: 0)
        self.buttonsVisible.toggle()
      }
    }

    UIView.animate(withDuration: 0.3) {
      let alpha: CGFloat = self.buttonsVisible ? 1 : 0
      let offset: CGFloat = self.buttonsVisible ? 6 : 0
      self.cameraOptionButton.alpha = alpha
      self.manualOptionButton.alpha = alpha

      self.cameraOptionButton.transform = CGAffineTransform(translationX: -offset, y: 0)
      self.manualOptionButton.transform = CGAffineTransform(translationX: offset, y: 0)
    }
  }
}
