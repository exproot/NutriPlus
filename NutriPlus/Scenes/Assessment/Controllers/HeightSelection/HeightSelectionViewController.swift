//
//  HeightSelectionViewController.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 25.12.2024.
//

import UIKit
import Combine

enum HeightUnit {
  case centimeter
  case feet
}

final class HeightSelectionViewController: BaseAssessmentViewController {
  lazy var viewModel = HeightSelectionViewModel()
  private var cancellables: Set<AnyCancellable> = []

  // MARK: - UI Components
  lazy var bodyMeasurementView = BodyMeasurementView(measurementType: .height)
  
  // MARK: - Controller Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    setupActions()
    setupBindings()
  }

  private func setupBindings() {
    viewModel.$heightInCm
      .combineLatest(viewModel.$selectedUnit)
      .throttle(for: .milliseconds(100), scheduler: DispatchQueue.main, latest: true)
      .receive(on: DispatchQueue.main)
      .sink { [weak self] _ in
        self?.updateHeightLabel()
      }
      .store(in: &cancellables)
  }

  // MARK: - UI Setup
  func updateHeightLabel() {
    bodyMeasurementView.valueLabel.text = viewModel.heightString()
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
