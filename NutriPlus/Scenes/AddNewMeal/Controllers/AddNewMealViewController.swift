//
//  AddNewMealViewController.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 18.12.2024.
//

import UIKit

final class AddNewMealViewController: KeyboardHandlingViewController {
  lazy var viewModel = AddNewMealViewModel()
  weak var delegate: AddNewMealControllerDelegate?

  // MARK: - UI Components
  lazy var headerView = AddNewMealHeaderView()
  private lazy var mealTitleLabel = CustomLabel(text: "Meal Name", fontSize: 18, fontWeight: .bold, textColor: .label)
  lazy var mealNameTextField = CustomTextField(placeholder: "Enter your meal's name...", fontSize: 16, fontWeight: .bold, cornerRadius: 10)
  lazy var mealTypeLabel = CustomLabel(text: "Meal Type", fontSize: 18, fontWeight: .bold, textColor: .label)
  var collectionView: UICollectionView!
  lazy var sliderStackView = AddNewMealStackView()
  lazy var continueButton = CustomButton(title: "Continue", backgroundColor: .label, foregroundColor: .systemBackground)

  // MARK: - Controller Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupCollectionView()
    setupUI()
    setupConstraints()
    setupActions()

    mealNameTextField.delegate = self
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.navigationBar.isHidden = true
    tabBarController?.tabBar.isHidden = true
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    navigationController?.navigationBar.isHidden = false
    tabBarController?.tabBar.isHidden = false
  }
}

// MARK: - SetupUI
extension AddNewMealViewController {
  private func setupUI() {
    navigationItem.hidesBackButton = true
    view.backgroundColor = .systemBackground
    view.addSubview(headerView)
    view.addSubview(mealTitleLabel)
    view.addSubview(mealNameTextField)
    view.addSubview(mealTypeLabel)
    view.addSubview(collectionView)
    view.addSubview(sliderStackView)
    view.addSubview(continueButton)
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      headerView.topAnchor.constraint(equalTo: view.topAnchor),
      headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      headerView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.23),

      mealTitleLabel.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
      mealTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),

      mealNameTextField.topAnchor.constraint(equalTo: mealTitleLabel.bottomAnchor, constant: 16),
      mealNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
      mealNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
      mealNameTextField.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.07),

      mealTypeLabel.topAnchor.constraint(equalTo: mealNameTextField.bottomAnchor, constant: 16),
      mealTypeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),

      collectionView.topAnchor.constraint(equalTo: mealTypeLabel.bottomAnchor, constant: 10),
      collectionView.leadingAnchor.constraint(equalTo: mealNameTextField.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: mealNameTextField.trailingAnchor),
      collectionView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.08),

      sliderStackView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 20),
      sliderStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
      sliderStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
      sliderStackView.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: -30),

      continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
      continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
      continueButton.heightAnchor.constraint(equalToConstant: 50)
    ])
  }
}
