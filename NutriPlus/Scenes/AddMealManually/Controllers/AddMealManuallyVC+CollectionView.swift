//
//  AddMealManuallyVC+CollectionView.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 20.12.2024.
//

import UIKit

// MARK: - UICollectionViewDataSource
extension AddMealManuallyViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    viewModel.mealTypes.count
  }
}

// MARK: - UICollectionViewDelegate
extension AddMealManuallyViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MealTypeCell.reuseID, for: indexPath) as? MealTypeCell else { return UICollectionViewCell() }
    cell.configure(title: viewModel.mealTypes[indexPath.item])
    return cell
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    viewModel.selectedMealTypeIndex = indexPath.item
  }
}

extension AddMealManuallyViewController {
  func setupCollectionView() {
    collectionView = UICollectionView(frame: .zero, collectionViewLayout: .createMealTypeLayout())
    collectionView.register(MealTypeCell.self, forCellWithReuseIdentifier: MealTypeCell.reuseID)
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.translatesAutoresizingMaskIntoConstraints = false
  }
}
