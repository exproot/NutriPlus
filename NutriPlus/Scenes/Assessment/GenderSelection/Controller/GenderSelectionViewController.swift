//
//  GenderSelectionViewController.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 23.10.2024.
//

import UIKit
import Combine

final class GenderSelectionViewController: BaseAssessmentViewController {
  lazy var viewModel = GenderSelectionViewModel()
  private var cancellables: Set<AnyCancellable> = []

  // MARK: - UI Components
  private lazy var titleLabel = CustomLabel(text: "What is your gender?", fontSize: 28, fontWeight: .bold, textColor: .black, alignment: .center, numberOfLines: 0)
  lazy var maleSelectionView = GenderView(image: UIImage(named: "male"), gender: "♂️Male")
  lazy var femaleSelectionView = GenderView(image: UIImage(named: "female"), gender: "♀️Female")

  private lazy var stackView: UIStackView = {
    let sv = UIStackView(arrangedSubviews: [maleSelectionView, femaleSelectionView])
    sv.axis = .vertical
    sv.distribution = .fillEqually
    sv.spacing = 20
    sv.translatesAutoresizingMaskIntoConstraints = false
    return sv
  }()
  
  lazy var continueButton = CustomButton()

  // MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    setupActions()
    setupBindings()
  }

  private func setupBindings() {
    viewModel.$selectedGender
      .receive(on: DispatchQueue.main)
      .sink { [weak self] gender in
        self?.updateSelectionState(for: gender)
      }
      .store(in: &cancellables)

    viewModel.$isContinueButtonEnabled
      .assign(to: \.isEnabled, on: continueButton)
      .store(in: &cancellables)
  }

  // MARK: - UI Setup
  private func updateSelectionState(for gender: Gender) {
    maleSelectionView.isSelectedOption = gender == .male
    femaleSelectionView.isSelectedOption = gender == .female
  }

  private func setupUI() {
    view.backgroundColor = .white
    view.addSubview(titleLabel)
    view.addSubview(stackView)
    view.addSubview(continueButton)
    
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
      titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      
      stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
      stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      stackView.heightAnchor.constraint(equalToConstant: 300),
      
      continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
      continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      continueButton.heightAnchor.constraint(equalToConstant: 50)
    ])
  }
}
