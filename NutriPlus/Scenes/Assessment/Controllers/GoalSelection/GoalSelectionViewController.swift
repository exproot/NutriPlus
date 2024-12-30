//
//  GoalSelectionViewController.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 24.10.2024.
//

import UIKit
import FirebaseAuth
import Combine

final class GoalSelectionViewController: BaseAssessmentViewController {
  lazy var viewModel = GoalSelectionViewModel(assessmentService: AssessmentService(uid: AuthUtils.shared.getCurrentUserUid()))
  private var cancellables: Set<AnyCancellable> = []

  // MARK: - UI Components
  private let titleLabel = CustomLabel(text: "What is your main \n goal/target?", fontSize: 28, fontWeight: .bold, textColor: .black, alignment: .center, numberOfLines: 0)
  lazy var tableView = UITableView()
  lazy var continueButton = CustomButton()

  // MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    setupActions()
    configureTableView()
    setupBindings()
  }

  private func setupBindings() {
    viewModel.$selectedGoal
      .receive(on: DispatchQueue.main)
      .sink { [weak self] _ in
        self?.tableView.reloadData()
      }
      .store(in: &cancellables)

    viewModel.$selectedGoal
      .map { $0 != nil }
      .assign(to: \.isEnabled, on: continueButton)
      .store(in: &cancellables)
  }

  // MARK: - UI Setup
  private func setupUI() {
    view.backgroundColor = .white
    view.addSubview(titleLabel)
    view.addSubview(tableView)
    view.addSubview(continueButton)

    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
      titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      
      tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
      tableView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
      tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      tableView.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: -40),
      
      continueButton.heightAnchor.constraint(equalToConstant: 50),
      continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
    ])
  }
}
