//
//  ScanResultViewController.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 22.12.2024.
//

import UIKit

final class ScanResultViewController: UIViewController {
  weak var delegate: ScanResultControllerDelegate?
  lazy var viewModel = ScanResultViewModel(meal: nil)
  
  // MARK: - UI Components
  lazy var modalHeaderView = CustomModalHeaderView(title: "AI Scan Result")
  private lazy var mealCalorie = CustomLabel(text: "", fontSize: 18, fontWeight: .semibold, textColor: .secondaryLabel, alignment: .center)
  private lazy var mealTitle = CustomLabel(text: "", fontSize: 28, fontWeight: .bold, textColor: .label, numberOfLines: 2)
  private lazy var mealDescription = CustomLabel(text: "", fontSize: 12, fontWeight: .semibold, textColor: .secondaryLabel, numberOfLines: 0)
  private lazy var nutrientsStackView = ScanResultStackView()

  // MARK: - Controller Lifecycle
  init(meal: Meal) {
    super.init(nibName: nil, bundle: nil)
    viewModel.meal = meal
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    setupConstraints()
    setupActions()
    configureViews()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    nutrientsStackView.configureProgressViews(values: viewModel.getNutrientValues())
  }

  // MARK: - UI Setup
  private func configureViews() {
    guard let meal = viewModel.meal else { return }

    mealTitle.text = meal.name
    mealDescription.text = meal.detail
    mealDescription.lineBreakMode = .byWordWrapping
    mealCalorie.text = "\(meal.calories) kcal"
  }

  private func setupUI() {
    view.backgroundColor = .systemBackground
    view.addSubview(modalHeaderView)
    view.addSubview(mealCalorie)
    view.addSubview(mealTitle)
    view.addSubview(mealDescription)
    view.addSubview(nutrientsStackView)
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      modalHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      modalHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      modalHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      modalHeaderView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.13),

      mealCalorie.topAnchor.constraint(equalTo: modalHeaderView.bottomAnchor, constant: 16),
      mealCalorie.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      mealCalorie.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25),

      mealTitle.topAnchor.constraint(equalTo: modalHeaderView.bottomAnchor, constant: 16),
      mealTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      mealTitle.trailingAnchor.constraint(equalTo: mealCalorie.leadingAnchor),

      mealDescription.topAnchor.constraint(equalTo: mealTitle.bottomAnchor, constant: 12),
      mealDescription.leadingAnchor.constraint(equalTo: mealTitle.leadingAnchor),
      mealDescription.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

      nutrientsStackView.topAnchor.constraint(equalTo: mealDescription.bottomAnchor, constant: 20),
      nutrientsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      nutrientsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      nutrientsStackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.45)
    ])
  }
}
