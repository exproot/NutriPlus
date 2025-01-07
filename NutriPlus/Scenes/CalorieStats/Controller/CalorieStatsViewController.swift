//
//  CalorieStatsViewController.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 6.01.2025.
//

import UIKit
import Combine

final class CalorieStatsViewController: UIViewController {
  let viewModel: CalorieStatsViewModel
  private var cancellables: Set<AnyCancellable> = []

  // MARK: - UI Components
  private lazy var calorieLabel = CustomLabel(text: "", fontSize: 32, fontWeight: .bold, textColor: .label)
  private lazy var proteinBarView = CustomBarView()
  private lazy var carbsBarView = CustomBarView()
  private lazy var fatBarView = CustomBarView()
  private lazy var stackView: UIStackView = {
    let customStack = UIStackView(arrangedSubviews: [proteinBarView, carbsBarView, fatBarView])
    customStack.axis = .horizontal
    customStack.spacing = 15
    customStack.distribution = .fillEqually
    customStack.translatesAutoresizingMaskIntoConstraints = false
    return customStack
  }()
  var macronutrientsTableView: UITableView!

  init(totalMeals: [MealCellViewModel]) {
    viewModel = CalorieStatsViewModel(meals: totalMeals)
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTableView()
    setupUI()
    configureNavigationBar()
    setupBindings()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.navigationBar.isHidden = false
    navigationController?.navigationBar.tintColor = .label
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    navigationController?.navigationBar.isHidden = true
  }

  private func setupBindings() {
    viewModel.$totalCaloriesText
      .sink { [weak self] text in
        self?.calorieLabel.text = text
      }
      .store(in: &cancellables)

    viewModel.$proteinPercentage
      .combineLatest(viewModel.$carbPercentage, viewModel.$fatPercentage)
      .sink { [weak self] protein, carb, fat in
        self?.updateBars(protein: protein, carb: carb, fat: fat)
      }
      .store(in: &cancellables)
  }

  // MARK: - UI Setup
  private func updateBars(protein: Double, carb: Double, fat: Double) {
    proteinBarView.updateProgressBar(percentage: protein, color: .systemGreen)
    carbsBarView.updateProgressBar(percentage: carb, color: .systemYellow)
    fatBarView.updateProgressBar(percentage: fat, color: .systemRed)
  }

  private func configureNavigationBar() {
    title = "Calorie Stats (Daily)"
  }

  private func setupUI() {
    view.backgroundColor = .systemBackground
    view.addSubview(calorieLabel)
    view.addSubview(stackView)
    view.addSubview(macronutrientsTableView)

    NSLayoutConstraint.activate([
      calorieLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
      calorieLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

      stackView.topAnchor.constraint(equalTo: calorieLabel.bottomAnchor, constant: 32),
      stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
      stackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25),

      macronutrientsTableView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
      macronutrientsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      macronutrientsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      macronutrientsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
  }
}


