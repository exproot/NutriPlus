//
//  HomeVC+CollectionView.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 2.01.2025.
//

import UIKit

// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    switch HomeSections(rawValue: indexPath.section) {
    case .calorieGoal:
      let controller = CalorieStatsViewController(totalMeals: viewModel.meals)

      navigationController?.pushViewController(controller, animated: true)
    case .condition:

      let assessmentService = AssessmentService(uid: AuthUtils.shared.getCurrentUserUid())
      let controller = indexPath.item == 0 ? BMIViewController(viewModel: BMIViewModel(assessmentService: assessmentService)) : BMRViewController()

      navigationController?.pushViewController(controller, animated: true)
    case .ai:
      let controller = ChatViewController(with: "Hey")

      navigationController?.pushViewController(controller, animated: true)
    default:
      break
    }
  }
}

extension HomeViewController {
  func setupCollectionView() {
    let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
      return HomeSectionProvider.createLayoutSection(for: sectionIndex)
    }

    homeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    homeCollectionView.delegate = self
    homeCollectionView.register(CalorieGoalCell.self, forCellWithReuseIdentifier: CalorieGoalCell.reuseIdentifier)
    homeCollectionView.register(BodyConditionCell.self, forCellWithReuseIdentifier: BodyConditionCell.reuseIdentifier)
    homeCollectionView.register(AIPromotionCell.self, forCellWithReuseIdentifier: AIPromotionCell.reuseIdentifier)
    homeCollectionView.register(HomeHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HomeHeaderView.identifier)
    homeCollectionView.translatesAutoresizingMaskIntoConstraints = false
  }
}
