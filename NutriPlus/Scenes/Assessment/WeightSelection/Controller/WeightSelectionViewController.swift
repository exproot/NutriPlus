//
//  WeightSelectionViewController.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 23.10.2024.
//

import UIKit
import Lottie
import Combine

final class WeightSelectionViewController: BaseAssessmentViewController {
  lazy var viewModel = WeightSelectionViewModel()
  private var cancellables: Set<AnyCancellable> = []
  
  // MARK: - UI Components
  lazy var bodyMeasurementView = BodyMeasurementView(measurementType: .weight)
  
  // MARK: - Life Viewcycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    setupActions()
    setupBindings()
  }

  private func setupBindings() {
    viewModel.$weightInKg
      .combineLatest(viewModel.$selectedUnit)
      .throttle(for: .milliseconds(100), scheduler: DispatchQueue.main, latest: true)
      .receive(on: DispatchQueue.main)
      .sink { [weak self] _ in
        self?.updateWeightLabel()
      }
      .store(in: &cancellables)
  }

  // MARK: - UI Setup
  private func updateWeightLabel() {
    bodyMeasurementView.valueLabel.text = viewModel.weightString()
  }
  
  private func setupUI() {
    view.backgroundColor = .white
    view.addSubview(bodyMeasurementView)
    
    NSLayoutConstraint.activate([
      bodyMeasurementView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
      bodyMeasurementView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      bodyMeasurementView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      bodyMeasurementView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
  }
}
