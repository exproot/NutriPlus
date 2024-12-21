//
//  MyMealsViewController+Selectors.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 21.12.2024.
//

import UIKit

// MARK: - Selectors
extension MyMealsViewController {
  @objc func handleAddButton() {
    guard viewModel.isSelectedDateToday() else {
      print("you can only add meals to the current day!")
      return
    }
    let addMealController = AddNewMealViewController()
    addMealController.delegate = self
    hidesBottomBarWhenPushed = true
    navigationController?.pushViewController(addMealController, animated: true)
  }

  @objc func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
    let location = gesture.location(in: collectionView)
    guard let indexPath = collectionView.indexPathForItem(at: location) else { return }

    if indexPath.section == 1 {
      if gesture.state == .began {
        showActionSheet(for: indexPath)
      }
    }
  }
}
