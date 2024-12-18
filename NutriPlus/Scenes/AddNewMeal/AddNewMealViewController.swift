//
//  AddNewMealViewController.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 18.12.2024.
//

import UIKit

protocol AddNewMealControllerDelegate: AnyObject {
  func addNewMealController(didAddManually meal: String)
}

final class AddNewMealViewController: UIViewController {
  weak var delegate: AddNewMealControllerDelegate?
  private let mealTypes = ["Breakfast", "Dinner", "Snack"]

  // MARK: - UI Components
  private lazy var headerView = AddNewMealHeaderView()
  private lazy var mealTitleLabel = CustomLabel(text: "Meal Name", fontSize: 24, fontWeight: .bold, textColor: .label)

  private lazy var mealNameTextField: UITextField = {
    let textField = UITextField()
    textField.placeholder = "Enter your meal name..."
    textField.font = .systemFont(ofSize: 16, weight: .bold)
    textField.layer.cornerRadius = 16
    textField.textAlignment = .center
    textField.backgroundColor = .systemGray5
    textField.translatesAutoresizingMaskIntoConstraints = false
    return textField
  }()

  private lazy var mealTypeLabel = CustomLabel(text: "Meal Type", fontSize: 18, fontWeight: .bold, textColor: .label)

  private lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    layout.itemSize = CGSize(width: 120, height: 50)
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.register(MealTypeCell.self, forCellWithReuseIdentifier: MealTypeCell.reuseID)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    return collectionView
  }()

  private lazy var proteinSlider = MacroSliderView(title: "Total Protein", imageString: "protein", sliderMinValue: 10, sliderMaxValue: 30, sliderColor: .systemGreen)
  private lazy var carbsSlider = MacroSliderView(title: "Total Carbs", imageString: "carbs", sliderMinValue: 10, sliderMaxValue: 30, sliderColor: .systemYellow)
  private lazy var fatsSlider = MacroSliderView(title: "Total Fat", imageString: "fats", sliderMinValue: 10, sliderMaxValue: 30, sliderColor: .systemRed)

  private lazy var sliderStackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [proteinSlider, carbsSlider, fatsSlider])
    stackView.axis = .vertical
    stackView.spacing = 5
    stackView.distribution = .equalSpacing
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()

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

  // MARK: - Selectors
  @objc private func handleContinueButton() {
    delegate?.addNewMealController(didAddManually: "")
    navigationController?.popViewController(animated: true)
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

// MARK: - UICollectionViewDataSource
extension AddNewMealViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    mealTypes.count
  }
}

// MARK: - UICollectionViewDelegate
extension AddNewMealViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MealTypeCell.reuseID, for: indexPath) as? MealTypeCell else { return UICollectionViewCell() }
    cell.configure(title: mealTypes[indexPath.item])
    return cell
  }
}

// MARK: - Layouts
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
      headerView.heightAnchor.constraint(equalToConstant: 170),

      mealTitleLabel.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
      mealTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),

      mealNameTextField.topAnchor.constraint(equalTo: mealTitleLabel.bottomAnchor, constant: 20),
      mealNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
      mealNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
      mealNameTextField.heightAnchor.constraint(equalToConstant: 60),

      mealTypeLabel.topAnchor.constraint(equalTo: mealNameTextField.bottomAnchor, constant: 20),
      mealTypeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),

      collectionView.topAnchor.constraint(equalTo: mealTypeLabel.bottomAnchor, constant: 10),
      collectionView.leadingAnchor.constraint(equalTo: mealNameTextField.leadingAnchor, constant: 8),
      collectionView.trailingAnchor.constraint(equalTo: mealNameTextField.trailingAnchor, constant: -8),
      collectionView.heightAnchor.constraint(equalToConstant: 80),

      sliderStackView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 30),
      sliderStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
      sliderStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
      sliderStackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.28),

      continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
      continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
      continueButton.heightAnchor.constraint(equalToConstant: 50)
    ])

    continueButton.addTarget(self, action: #selector(handleContinueButton), for: .touchUpInside)
  }
}
