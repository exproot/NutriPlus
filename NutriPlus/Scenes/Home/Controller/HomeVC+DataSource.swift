//
//  HomeVC+DataSource.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 2.01.2025.
//

import UIKit

extension HomeViewController {
  func applyInitialSnapshot() {
    var snapshot = NSDiffableDataSourceSnapshot<HomeSections, AnyHashable>()
    snapshot.appendSections([.calorieGoal, .condition, .ai])
    snapshot.appendItems([AIPromotionCellViewModel(title: "Nutri AI")], toSection: .ai)
    dataSource.apply(snapshot, animatingDifferences: false)
  }

  func updateConditionSection() {
    guard let bmiCellViewModel = viewModel.bmiConditionCellViewModel, let bmrCellViewModel = viewModel.bmrConditionCellViewModel else { return }

    var snapshot = dataSource.snapshot()

    if snapshot.indexOfSection(.condition) != nil {
      snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .condition))
      snapshot.appendItems([bmiCellViewModel, bmrCellViewModel], toSection: .condition)
    }

    dataSource.apply(snapshot, animatingDifferences: false)
  }

  func updateCalorieGoalSection() {
    guard let calorieGoalViewModel = viewModel.calorieGoalCellViewModel else { return }

    var snapshot = dataSource.snapshot()
    let currentItems = snapshot.itemIdentifiers(inSection: .calorieGoal)

    if currentItems != [calorieGoalViewModel] {
      snapshot.deleteItems(currentItems)
      snapshot.appendItems([calorieGoalViewModel], toSection: .calorieGoal)
    }

    dataSource.apply(snapshot, animatingDifferences: false)
  }
}

extension HomeViewController {
  func setupDataSource() {
    dataSource = UICollectionViewDiffableDataSource<HomeSections, AnyHashable>(collectionView: homeCollectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
      switch HomeSections(rawValue: indexPath.section) {
      case .calorieGoal:
        guard
          let cell = collectionView.dequeueCell(ofType: CalorieGoalCell.self, withIdentifier: CalorieGoalCell.reuseIdentifier, for: indexPath),
          let cellViewModel = item as? CalorieGoalCellViewModel
        else {
          fatalError("error dequeueing CalorieGoalCell")
        }
        cell.configure(cellViewModel)
        return cell
      case .condition:
        guard
          let cell = collectionView.dequeueCell(ofType: BodyConditionCell.self, withIdentifier: BodyConditionCell.reuseIdentifier, for: indexPath),
          let cellViewModel = item as? ConditionCellViewModel
        else {
          fatalError("error dequeueing BodyConditionCell")
        }
        cell.configure(cellViewModel)
        return cell
      case .ai:
        guard 
          let cell = collectionView.dequeueCell(ofType: AIPromotionCell.self, withIdentifier: AIPromotionCell.reuseIdentifier, for: indexPath),
          let cellViewModel = item as? AIPromotionCellViewModel
        else {
          fatalError("error dequeueing AIPromotionCell")
        }
        cell.configure(cellViewModel)
        return cell
      default:
        return nil
      }
    })

    dataSource.supplementaryViewProvider = { (collectionView, elementKind, indexPath) -> UICollectionReusableView in
      guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HomeHeaderView.identifier, for: indexPath) as? HomeHeaderView else { fatalError("error dequeueing HomeHeaderView") }
      let sectionTitle = HomeSections(rawValue: indexPath.section)?.sectionTitle ?? "Home"

      headerView.configure(sectionTitle)
      return headerView
    }
  }
}

extension UICollectionView {
  func dequeueCell<T: UICollectionViewCell>(ofType type: T.Type, withIdentifier identifier: String, for indexPath: IndexPath) -> T? {
    self.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? T
  }
}
