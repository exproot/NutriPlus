//
//  SelectAgeViewController.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 23.10.2024.
//

import UIKit
import Combine

final class AgeSelectionViewController: BaseAssessmentViewController {
  lazy var viewModel = AgeSelectionViewModel()
  private var cancellables: Set<AnyCancellable> = []

  // MARK: - UI Components
  private lazy var agePickerView = UIPickerView()
  private let titleLabel = CustomLabel(text: "What's your age?", fontSize: 32, fontWeight: .bold, textColor: .black, alignment: .center, numberOfLines: 0)
  private let continueButton = CustomButton()
  
  // MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    setupBindings()
  }

  func setupBindings() {
    viewModel.$selectedAge
      .receive(on: DispatchQueue.main)
      .sink { [weak self] age in
        self?.agePickerView.selectRow(age - 1, inComponent: 0, animated: true)
        self?.agePickerView.reloadAllComponents()
      }
      .store(in: &cancellables)
  }
}

// MARK: - UI Setup & Constraints
extension AgeSelectionViewController {
  private func configurePickerView() {
    agePickerView.translatesAutoresizingMaskIntoConstraints = false
    agePickerView.delegate = self
    agePickerView.dataSource = self
    view.addSubview(agePickerView)
  }

  private func setupUI() {
    view.backgroundColor = .white
    configurePickerView()
    view.addSubview(titleLabel)
    view.addSubview(continueButton)
    setupConstraints()
  }

  func setupConstraints() {
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
      titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      titleLabel.heightAnchor.constraint(equalToConstant: 35),

      agePickerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
      agePickerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3),
      agePickerView.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: -20),
      agePickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),

      continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
      continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      continueButton.heightAnchor.constraint(equalToConstant: 50)
    ])

    continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
  }
}
