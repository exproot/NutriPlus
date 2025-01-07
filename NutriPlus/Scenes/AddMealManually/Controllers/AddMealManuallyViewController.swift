//
//  AddMealManuallyViewController.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 18.12.2024.
//

import UIKit

final class AddMealManuallyViewController: KeyboardHandlingViewController {
  lazy var viewModel = AddMealManuallyViewModel()
  weak var delegate: AddMealManuallyDelegate?

  // MARK: - UI Components
  lazy var modalHeaderView = CustomModalHeaderView(title: "Add Meal")
  private lazy var mealTitleLabel = CustomLabel(text: "Meal Name", fontSize: 18, fontWeight: .bold, textColor: .label)
  lazy var mealNameTextField = CustomTextField(placeholder: "Enter your meal's name...", fontSize: 16, fontWeight: .bold, cornerRadius: 10, backgroundColor: .systemGray5)
  lazy var mealTypeLabel = CustomLabel(text: "Meal Type", fontSize: 18, fontWeight: .bold, textColor: .label)
  var collectionView: UICollectionView!
  lazy var sliderStackView = AddMealManuallyStackView()
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
}

// MARK: - SetupUI
extension AddMealManuallyViewController {
  private func setupUI() {
    title = "Add Meal"
    view.backgroundColor = .systemBackground
    view.addSubview(modalHeaderView)
    view.addSubview(mealTitleLabel)
    view.addSubview(mealNameTextField)
    view.addSubview(mealTypeLabel)
    view.addSubview(collectionView)
    view.addSubview(sliderStackView)
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      modalHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      modalHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      modalHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      modalHeaderView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.07),

      mealTitleLabel.topAnchor.constraint(equalTo: modalHeaderView.bottomAnchor, constant: 20),
      mealTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),

      mealNameTextField.topAnchor.constraint(equalTo: mealTitleLabel.bottomAnchor, constant: 16),
      mealNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      mealNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
      mealNameTextField.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.07),

      mealTypeLabel.topAnchor.constraint(equalTo: mealNameTextField.bottomAnchor, constant: 16),
      mealTypeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),

      collectionView.topAnchor.constraint(equalTo: mealTypeLabel.bottomAnchor, constant: 10),
      collectionView.leadingAnchor.constraint(equalTo: mealNameTextField.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: mealNameTextField.trailingAnchor),
      collectionView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.08),

      sliderStackView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 20),
      sliderStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      sliderStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
      sliderStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40)
    ])
  }
}
