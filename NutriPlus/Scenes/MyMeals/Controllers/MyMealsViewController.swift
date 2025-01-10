//
//  MyMealsViewController.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 7.11.2024.
//

import UIKit

final class MyMealsViewController: UIViewController {
  lazy var viewModel = MyMealsViewModel(mealService: MealService(uid: AuthUtils.shared.getCurrentUserUid()))
  var dataSource: UICollectionViewDiffableDataSource<Section, AnyHashable>!
  var collectionView: UICollectionView!
  let emptyStateView = MealsEmptyStateView()

  // MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    configureNavigationBar()
    configureDataSource()
    applyInitialSnapshot()

    if let tabBar = tabBarController as? MainTabBarController {
      tabBar.tabBarButtonsDelegate = self
    }
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    guard let selectedIndex = viewModel.selectedIndex else { return }
    let selectedDate = viewModel.dateItems[selectedIndex].dateString

    viewModel.fetchMeals(for: selectedDate) { [weak self] in
      let indexPath = IndexPath(item: selectedIndex, section: 0)

      self?.updateMealSection()
      self?.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
      self?.updateEmptyStateVisibility()
    }
  }
}

// MARK: - UI Setup
extension MyMealsViewController {
  func updateEmptyStateVisibility() {
    let hasMeals = !viewModel.mealItems.isEmpty
    emptyStateView.isHidden = hasMeals
  }

  func pushChatController(with message: String) {
    let chatController = ChatViewController(with: message)
    navigationController?.pushViewController(chatController, animated: true)
  }

  private func configureNavigationBar() {
    title = "My Meals"
  }

  private func setupUI() {
    view.backgroundColor = .systemBackground
    setupCollectionView()

    view.insertSubview(emptyStateView, aboveSubview: collectionView)

    NSLayoutConstraint.activate([
      emptyStateView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      emptyStateView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      emptyStateView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.65),
      emptyStateView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.35)
    ])
  }
}
