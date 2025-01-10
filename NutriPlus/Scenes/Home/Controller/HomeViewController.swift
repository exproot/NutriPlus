//
//  HomeViewController.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 23.10.2024.
//

import UIKit
import Combine

final class HomeViewController: UIViewController {
  lazy var viewModel = HomeViewModel (
    authService: AuthService(),
    assessmentService: AssessmentService(uid: AuthUtils.shared.getCurrentUserUid()),
    mealService: MealService(uid: AuthUtils.shared.getCurrentUserUid()),
    strategy: HarrisBenedictBMRCalculation()
  )
  private var cancellables: Set<AnyCancellable> = []

  // MARK: - UI Components
  lazy var profileHeaderView = ProfileHeaderView()
  var homeCollectionView: UICollectionView!
  var dataSource: UICollectionViewDiffableDataSource<HomeSections, AnyHashable>!

  override func viewDidLoad() {
    super.viewDidLoad()
    setupCollectionView()
    setupDataSource()
    applyInitialSnapshot()
    setupUI()
    setupConstraints()
    setupActions()
    setupBindings()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.navigationBar.isHidden = true
    viewModel.reloadMeals()
  }

  private func setupBindings() {
    viewModel.$greetingText
      .combineLatest(viewModel.$userImageString, viewModel.$dateText)
      .receive(on: DispatchQueue.main)
      .sink { [weak self] greetingText, imageString, dateText in
        self?.profileHeaderView.configure(imageString: imageString, isSystemImage: true, imageTintColor: .white, dateText: dateText, greetingText: greetingText)
      }
      .store(in: &cancellables)

    viewModel.$bmiConditionCellViewModel
      .combineLatest(viewModel.$bmrConditionCellViewModel)
      .receive(on: DispatchQueue.main)
      .sink { [weak self] _ in
        self?.updateConditionSection()
      }
      .store(in: &cancellables)

    viewModel.$calorieGoalCellViewModel
      .removeDuplicates()
      .receive(on: DispatchQueue.main)
      .sink { [weak self] _ in
        self?.updateCalorieGoalSection()
      }
      .store(in: &cancellables)
  }
}

// MARK: - UI Setup
extension HomeViewController {
  private func setupUI() {
    view.backgroundColor = .systemBackground

    view.addSubview(profileHeaderView)
    view.addSubview(homeCollectionView)
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      profileHeaderView.topAnchor.constraint(equalTo: view.topAnchor),
      profileHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      profileHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      profileHeaderView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2),

      homeCollectionView.topAnchor.constraint(equalTo: profileHeaderView.bottomAnchor),
      homeCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      homeCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      homeCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
    ])
  }
}
