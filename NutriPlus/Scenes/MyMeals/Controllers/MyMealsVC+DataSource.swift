//
//  MyMealsViewController+DataSource.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 20.12.2024.
//

import UIKit

enum Section: Int {
  case dates
  case meals
}

extension MyMealsViewController {
  func applyInitialSnapshot() {
    var snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>()
    snapshot.appendSections([.dates, .meals])
    snapshot.appendItems(viewModel.dateItems, toSection: .dates)
    snapshot.appendItems(viewModel.mealItems, toSection: .meals)
    dataSource.apply(snapshot, animatingDifferences: false)
  }

  func configureDataSource() {
    dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { [weak self] collectionView, indexPath, itemIdentifier -> UICollectionViewCell? in
      guard let self = self else { return nil }
      switch itemIdentifier {
      case let dateViewModel as CalendarCellViewModel:
        guard let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarCell.identifier, for: indexPath) as? CalendarCell else { fatalError("couldn't dequeue calendar cell") }
        cell.configure(dateString: dateViewModel.dateString)
        return cell
      case let mealViewModel as MealCellViewModel:
        guard let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: MealCell.identifier, for: indexPath) as? MealCell else { fatalError("couldn't dequeue meal cell") }
        cell.configure(with: mealViewModel)
        cell.delegate = self
        return cell
      default:
        return nil
      }
    })
  }

  func updateMealSection() {
    var snapshot = dataSource.snapshot()

    if snapshot.indexOfSection(.meals) != nil {
      snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .meals))
      snapshot.appendItems(viewModel.mealItems, toSection: .meals)
    }

    updateEmptyStateVisibility()
    dataSource.apply(snapshot, animatingDifferences: true)
  }
}
