//
//  BMRViewController.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 29.12.2024.
//

import UIKit
import Combine

final class BMRViewController: UIViewController {
  lazy var viewModel = BMRViewModel(assessmentService: AssessmentService(uid: AuthUtils.shared.getCurrentUserUid()), strategy: HarrisBenedictBMRCalculation())
  private var cancellables: Set<AnyCancellable> = []

  // MARK: - UI Components
  private lazy var titleLabel = CustomLabel(text: "Your BMR is", fontSize: 32, fontWeight: .bold, textColor: .label)
  private lazy var bmrLabel = CustomLabel(text: "", fontSize: 40, fontWeight: .bold, textColor: .systemOrange)
  private lazy var progressView = BMRCircularProgressView()
  private lazy var targetLabel = CustomLabel(text: "", fontSize: 32, fontWeight: .bold, textColor: .label)
  private lazy var goalLabel = CustomLabel(text: "", fontSize: 20, fontWeight: .light, textColor: .label)
  private lazy var nutriAiButton =  CustomButton(title: "Get Insights from AI", backgroundColor: .systemOrange, foregroundColor: .systemBackground)

  // MARK: - Controller Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    setupBindings()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.navigationBar.isHidden = false
    navigationController?.navigationBar.tintColor = .label
    tabBarController?.tabBar.isHidden = true
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    navigationController?.navigationBar.isHidden = true
    tabBarController?.tabBar.isHidden = false
  }

  private func setupBindings() {
    viewModel.$progressValue
      .receive(on: DispatchQueue.main)
      .compactMap { $0 }
      .map { CGFloat($0) }
      .sink { [weak self] value in
        self?.progressView.setProgress(value, color: .systemOrange)
      }
      .store(in: &cancellables)

    viewModel.$bmrValueText
      .combineLatest(viewModel.$targetCaloriesText, viewModel.$goalText)
      .receive(on: DispatchQueue.main)
      .sink { [weak self] (bmrText, targetText, goalText) in
        self?.bmrLabel.text = bmrText
        self?.targetLabel.text = targetText
        self?.goalLabel.text = goalText
      }
      .store(in: &cancellables)
  }

  // MARK: - UI Setup
  private func configureLabels() {
    [titleLabel, bmrLabel, targetLabel, goalLabel].forEach {
      $0.textAlignment = .center
      $0.numberOfLines = 0

      view.addSubview($0)
    }
  }

  private func configureProgressView() {
    view.addSubview(progressView)
  }

  private func setupUI() {
    view.backgroundColor = .systemBackground
    configureLabels()
    configureProgressView()
    view.addSubview(nutriAiButton)
    setupConstraints()
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
      titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

      bmrLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
      bmrLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

      progressView.topAnchor.constraint(equalTo: bmrLabel.bottomAnchor, constant: 20),
      progressView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      progressView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.65),
      progressView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.35),

      targetLabel.centerYAnchor.constraint(equalTo: progressView.centerYAnchor),
      targetLabel.leadingAnchor.constraint(equalTo: progressView.leadingAnchor, constant: 8),
      targetLabel.trailingAnchor.constraint(equalTo: progressView.trailingAnchor, constant: -8),

      goalLabel.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 20),
      goalLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      goalLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

      nutriAiButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
      nutriAiButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      nutriAiButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.07),
      nutriAiButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9)
    ])

    nutriAiButton.addTarget(self, action: #selector(handleAIButton), for: .touchUpInside)
  }
}

// MARK: - Selectors
extension BMRViewController {
  @objc func handleAIButton() {
    let controller = ChatViewController(with: "BMR is \(bmrLabel.text ?? "1600") kcal", and: AIInstructions.bodyConditionBMR)

    navigationController?.pushViewController(controller, animated: true)
  }
}
