//
//  AddNewMealViewController.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 18.12.2024.
//

import UIKit

final class AddNewMealViewController: UIViewController {
  lazy var viewModel = AddNewMealViewModel()
  weak var delegate: AddNewMealControllerDelegate?

  // MARK: - UI Components
  private lazy var headerView = AddNewMealHeaderView()
  private lazy var mealTitleLabel = CustomLabel(text: "Meal Name", fontSize: 18, fontWeight: .bold, textColor: .label)

  lazy var mealNameTextField: UITextField = {
    let textField = UITextField()
    textField.placeholder = "Enter your meal's name..."
    textField.font = .systemFont(ofSize: 16, weight: .bold)
    textField.layer.cornerRadius = 12
    textField.textAlignment = .center
    textField.backgroundColor = .systemGray5
    textField.translatesAutoresizingMaskIntoConstraints = false
    return textField
  }()

  lazy var mealTypeLabel = CustomLabel(text: "Meal Type", fontSize: 18, fontWeight: .bold, textColor: .label)
  lazy var collectionView: UICollectionView = {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .createMealTypeLayout())
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.register(MealTypeCell.self, forCellWithReuseIdentifier: MealTypeCell.reuseID)
    return collectionView
  }()
  var sliderStackView = AddNewMealStackView()

  private lazy var continueButton: UIButton = {
    var config = UIButton.Configuration.filled()
    config.title = "Continue"
    config.baseForegroundColor = .systemBackground
    config.baseBackgroundColor = .label
    config.cornerStyle = .medium

    let btn = UIButton()
    btn.configuration = config
    btn.translatesAutoresizingMaskIntoConstraints = false
    return btn
  }()

  // MARK: - Controller Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    headerView.delegate = self
    collectionView.dataSource = self
    collectionView.delegate = self
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.navigationBar.isHidden = true
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    navigationController?.navigationBar.isHidden = false
  }
}

// MARK: - AddNewMealHeaderDelegate
extension AddNewMealViewController: AddNewMealHeaderDelegate {
  func addNewMealHeaderView(_ view: AddNewMealHeaderView, didSwitchSegment segmentIndex: Int) {
    if segmentIndex != 0 {
      // AI Scan seçildi
    }
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
      mealNameTextField.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.05),

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

    continueButton.addTarget(self, action: #selector(handleContinueButton), for: .touchUpInside)
  }
}
