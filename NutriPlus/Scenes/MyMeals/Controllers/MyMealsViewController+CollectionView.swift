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
