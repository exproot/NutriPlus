//
//  BMIViewController.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 27.12.2024.
//

import UIKit
import Combine

final class BMIViewController: UIViewController {
  let viewModel: BMIViewModel
  private var cancellables: Set<AnyCancellable> = []

  // MARK: - UI Components
  private lazy var titleLabel = CustomLabel(text: "Your BMI is", fontSize: 32, fontWeight: .bold, textColor: .label)
  private lazy var gradientView = BMIGradientView()
  private lazy var bmiLabel = CustomLabel(text: "", fontSize: 32, fontWeight: .bold, textColor: .white)
  private lazy var categoryLabel = CustomLabel(text: "", fontSize: 18, fontWeight: .light, textColor: .label)
  private lazy var helpLabel = CustomLabel(text: "We Can Help", fontSize: 32, fontWeight: .bold, textColor: .label)
  private lazy var bmiStackView = BMIStackView()

  // MARK: - Controller Lifecycle
  init(viewModel: BMIViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    setupBindings()
  }

  // MARK: - UI Setup
  private func setupBindings() {
    Publishers.CombineLatest3(viewModel.$bmiValueText, viewModel.$bmiCategoryText, viewModel.$bmiGradientColors)
      .sink { [weak self] result in
        self?.bmiLabel.text = result.0
        self?.categoryLabel.text = result.1
        self?.gradientView.setGradient(colors: result.2)
      }
      .store(in: &cancellables)
  }

  private func configureGradientView() {
    gradientView.layer.cornerRadius = 12
    gradientView.clipsToBounds = true
    view.addSubview(gradientView)
  }

  private func configureLabels() {
    [titleLabel, bmiLabel, categoryLabel, helpLabel].forEach {
      $0.numberOfLines = 0
      $0.textAlignment = .center
      view.addSubview($0)
    }
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
      titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

      gradientView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
      gradientView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      gradientView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      gradientView.heightAnchor.constraint(equalToConstant: 100),

      bmiLabel.centerXAnchor.constraint(equalTo: gradientView.centerXAnchor),
      bmiLabel.centerYAnchor.constraint(equalTo: gradientView.centerYAnchor),

      categoryLabel.topAnchor.constraint(equalTo: gradientView.bottomAnchor, constant: 16),
      categoryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      categoryLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

      helpLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 40),
      helpLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

      bmiStackView.topAnchor.constraint(equalTo: helpLabel.bottomAnchor, constant: 20),
      bmiStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      bmiStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      bmiStackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.26)
    ])
  }

  private func setupUI() {
    view.backgroundColor = .systemBackground
    configureGradientView()
    configureLabels()
    view.addSubview(bmiStackView)
    setupConstraints()
  }
}
