//
//  FitSelectionViewController.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 23.10.2024.
//

import UIKit
import Lottie
import Combine

final class FitSelectionViewController: BaseAssessmentViewController {
  lazy var viewModel = FitSelectionViewModel()
  private var cancellables: Set<AnyCancellable> = []

  // MARK: - UI Components
  private lazy var titleLabel = CustomLabel(text: "How would you rate your fitness level?", fontSize: 28, fontWeight: .bold, textColor: .black, alignment: .center, numberOfLines: 0)
  lazy var fitnessLevelLabel = CustomLabel(text: "3", fontSize: 80, fontWeight: .bold, textColor: .black, alignment: .center)
  lazy var fitnessDescriptionLabel = CustomLabel(text: "Somewhat Athletic", fontSize: 20, fontWeight: .regular, textColor: .black, alignment: .center)
  lazy var slider = CustomSlider(minVal: 1, maxVal: 5, thumbColor: .systemOrange, tintColor: .systemOrange)
  lazy var fitSelectionAnimation = CustomAnimation(name: "FitLevel", loopMode: .loop, contentMode: .scaleAspectFill)
  lazy var continueButton = CustomButton()

  // MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    setupActions()
    setupBindings()
  }

  private func setupBindings() {
    viewModel.$fitnessLevel
      .receive(on: DispatchQueue.main)
      .sink { [weak self] level in
        self?.fitnessLevelLabel.text = "\(level)"
        self?.fitnessDescriptionLabel.text = self?.viewModel.fitnessDescription(for: level)
      }
      .store(in: &cancellables)
  }

  // MARK: - UI Setup
  private func setupUI() {
    slider.value = 3
    view.backgroundColor = .white
    view.addSubview(titleLabel)
    view.addSubview(fitnessLevelLabel)
    view.addSubview(fitnessDescriptionLabel)
    view.addSubview(slider)
    view.addSubview(fitSelectionAnimation)
    view.addSubview(continueButton)
    
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
      titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      
      fitnessLevelLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
      fitnessLevelLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      
      fitnessDescriptionLabel.topAnchor.constraint(equalTo: fitnessLevelLabel.bottomAnchor, constant: 10),
      fitnessDescriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      
      slider.topAnchor.constraint(equalTo: fitnessDescriptionLabel.bottomAnchor, constant: 40),
      slider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
      slider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),

      fitSelectionAnimation.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: 40),
      fitSelectionAnimation.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      fitSelectionAnimation.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.23),
      fitSelectionAnimation.widthAnchor.constraint(equalToConstant: 150),

      continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
      continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      continueButton.heightAnchor.constraint(equalToConstant: 50)
    ])

    fitSelectionAnimation.play()
  }
}
