//
//  MyMealsViewController+CollectionView.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 20.12.2024.
//

import UIKit

// MARK: - UICollectionViewDelegate
extension MyMealsViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    switch indexPath.section {
    case 0:
      let selectedDate = viewModel.dateItems[indexPath.item].dateString
      viewModel.selectedIndex = indexPath.item
      viewModel.fetchMeals(for: selectedDate) { [weak self] in
        self?.updateMealSection()
      }
    default:
      break
    }
  }

  func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
    if indexPath.section == 0 {
      return true
    }
    
    return false
  }

  func collectionView(_ collectionView: UICollectionView, canEditItemAt indexPath: IndexPath) -> Bool {
    indexPath.section == 1
  }
}

extension MyMealsViewController {
  func addLongPressGesture() {
    let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
    collectionView.addGestureRecognizer(longPressGesture)
  }

  func showActionSheet(for indexPath: IndexPath) {
    guard let selectedDateIndex = viewModel.selectedIndex else { return }
    let meal = viewModel.mealItems[indexPath.item]
    let selectedDate = viewModel.dateItems[selectedDateIndex].dateString
    let currentDate = Date().toFormattedString()

    let actionSheet = UIAlertController(title: "Options", message: "Choose an option", preferredStyle: .actionSheet)
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
    actionSheet.addAction(cancelAction)

    let detailsAction = UIAlertAction(title: "Get Details", style: .default) { [weak self] _ in
      self?.pushChatController(with: meal.name)
    }
    actionSheet.addAction(detailsAction)

    if selectedDate == currentDate {
      let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
        self?.viewModel.deleteMeal(mealId: meal.id, dateString: selectedDate) {
          self?.updateMealSection()
        }
      }
      actionSheet.addAction(deleteAction)
    }

    present(actionSheet, animated: true)
  }
}

// MARK: - CollectionView Layout
extension MyMealsViewController {
  func setupCollectionView() {
    let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
      return MyMealsSectionProvider.createLayoutSection(for: sectionIndex)
    }

    collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(collectionView)

    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    ])

    collectionView.delegate = self
    collectionView.register(CalendarCell.self, forCellWithReuseIdentifier: CalendarCell.identifier)
    collectionView.register(MealCell.self, forCellWithReuseIdentifier: MealCell.identifier)
  }
}
