//
//  MyMealsViewController.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 7.11.2024.
//

import UIKit

final class MyMealsViewController: UIViewController {
  lazy var viewModel = MyMealsViewModel(mealService: MealService())
  var dataSource: UICollectionViewDiffableDataSource<Section, AnyHashable>!
  var collectionView: UICollectionView!

  // MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    configureNavigationBar()
    setupCollectionView()
    addLongPressGesture()
    configureDataSource()
    applyInitialSnapshot()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    guard let selectedIndex = viewModel.selectedIndex else { return }
    let selectedDate = viewModel.dateItems[selectedIndex].dateString

    viewModel.fetchMeals(for: selectedDate) { [weak self] in
      print("here")
      let indexPath = IndexPath(item: selectedIndex, section: 0)

      self?.updateMealSection()
      self?.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
    }
  }
}

// MARK: - AddNewMealControllerDelegate
extension MyMealsViewController: AddNewMealControllerDelegate {
  func addNewMealController(didAddWithAI meal: Meal) {
    guard let selectedDateIndex = viewModel.selectedIndex else { return }
    let date = viewModel.dateItems[selectedDateIndex].dateString
    let mealCellViewModel = MealCellViewModel(meal: meal)

    hidesBottomBarWhenPushed = false
    viewModel.addMeal(meal: mealCellViewModel, date: date) { [weak self] in
      self?.updateMealSection()
    }
  }
  
  func addNewMealController(didAddManually meal: MealCellViewModel) {
    guard let selectedDateIndex = viewModel.selectedIndex else { return }
    let date = viewModel.dateItems[selectedDateIndex].dateString

    hidesBottomBarWhenPushed = false
    viewModel.addMeal(meal: meal, date: date) { [weak self] in
      self?.updateMealSection()
    }
  }
}

// MARK: - UI Setup
extension MyMealsViewController {
  private func configureNavigationBar() {
    title = "My Meals"
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus")?.withTintColor(.label, renderingMode: .alwaysOriginal), style: .done, target: self, action: #selector(handleAddButton))
  }

  private func setupUI() {
    view.backgroundColor = .systemBackground
  }
}
