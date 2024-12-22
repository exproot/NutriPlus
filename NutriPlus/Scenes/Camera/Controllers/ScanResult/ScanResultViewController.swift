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

  init(meal: Meal) {
    super.init(nibName: nil, bundle: nil)
    viewModel.meal = meal
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - UI Components
  private lazy var controllerTitle = CustomLabel(text: "AI Scan Result", fontSize: 16, fontWeight: .bold, textColor: .label)
  private lazy var cancelButton = CameraButton(title: "Cancel", color: .systemRed)
  private lazy var doneButton = CameraButton(title: "Done", color: .systemBlue)
  private lazy var mealTitle = CustomLabel(text: "", fontSize: 28, fontWeight: .bold, textColor: .label)
  private lazy var seperatorView: UIView = {
    let customView = UIView()
    customView.backgroundColor = .systemFill
    customView.translatesAutoresizingMaskIntoConstraints = false
    return customView
  }()
  private lazy var mealCalorie = CustomLabel(text: "", fontSize: 18, fontWeight: .semibold, textColor: .secondaryLabel)
  private lazy var mealDescription = CustomLabel(text: "", fontSize: 12, fontWeight: .semibold, textColor: .secondaryLabel)
  private lazy var nutrientsStackView = ScanResultStackView()

  // MARK: - Controller Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
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
    mealCalorie.text = "\(meal.calories) kcal"
  }

  private func setupUI() {
    view.backgroundColor = .systemBackground

    mealTitle.numberOfLines = 2
    mealDescription.numberOfLines = 0
    mealDescription.lineBreakMode = .byWordWrapping
    mealCalorie.textAlignment = .center

    view.addSubview(controllerTitle)
    view.addSubview(cancelButton)
    view.addSubview(doneButton)
    view.addSubview(mealTitle)
    view.addSubview(seperatorView)
    view.addSubview(mealCalorie)
    view.addSubview(mealDescription)
    view.addSubview(nutrientsStackView)

    NSLayoutConstraint.activate([
      cancelButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
      cancelButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),

      doneButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
      doneButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),

      controllerTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      controllerTitle.centerYAnchor.constraint(equalTo: cancelButton.centerYAnchor),

      seperatorView.topAnchor.constraint(equalTo: cancelButton.bottomAnchor, constant: 8),
      seperatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      seperatorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      seperatorView.heightAnchor.constraint(equalToConstant: 1),

      mealCalorie.topAnchor.constraint(equalTo: seperatorView.bottomAnchor, constant: 16),
      mealCalorie.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      mealCalorie.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25),

      mealTitle.topAnchor.constraint(equalTo: seperatorView.bottomAnchor, constant: 16),
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

    cancelButton.addTarget(self, action: #selector(handleCancelButton), for: .touchUpInside)
    doneButton.addTarget(self, action: #selector(handleDoneButton), for: .touchUpInside)
  }

  // MARK: - Selectors
  @objc private func handleDoneButton() {
    dismiss(animated: true) { [weak self] in
      guard let self = self else { return }

      if let meal = viewModel.meal {
        self.delegate?.scanResultController(self, didConfirmMeal: meal)
      }
    }
  }

  @objc private func handleCancelButton() {
    dismiss(animated: true) { [weak self] in
      guard let self = self else { return }

      self.delegate?.scanResultControllerDidCancel(self)
    }
  }
}
