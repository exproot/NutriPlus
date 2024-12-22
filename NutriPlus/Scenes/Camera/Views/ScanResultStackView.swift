//
//  ScanResultStackView.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 22.12.2024.
//

import UIKit

final class ScanResultStackView: UIStackView {
  // MARK: - UI Components
  private lazy var proteinNutrientView = NutrientView(title: "Protein", value: 0.0, color: .systemGreen, imageString: "protein")
  private lazy var carbsNutrientView = NutrientView(title: "Carbs", value: 0.0, color: .systemYellow, imageString: "carbs")
  private lazy var fatsNutrientView = NutrientView(title: "Fat", value: 0.0, color: .systemRed, imageString: "fats")

  init() {
    super.init(frame: .zero)
    setupUI()
  }

  func configureProgressViews(values: [Int]) {
    let totalGrams = Float(values.reduce(0, +))
    let valuesAsFloat = values.map { Float($0) }

    proteinNutrientView.amountLabel.text = "\(values[0])g"
    carbsNutrientView.amountLabel.text = "\(values[1])g"
    fatsNutrientView.amountLabel.text = "\(values[2])g"

    proteinNutrientView.progressView.setProgress(valuesAsFloat[0] / totalGrams, animated: true)
    carbsNutrientView.progressView.setProgress(valuesAsFloat[1] / totalGrams, animated: true)
    fatsNutrientView.progressView.setProgress(valuesAsFloat[2] / totalGrams, animated: true)
  }

  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - UI Setup
  private func setupUI() {
    axis = .vertical
    spacing = 35
    distribution = .equalSpacing
    translatesAutoresizingMaskIntoConstraints = false
    addArrangedSubview(proteinNutrientView)
    addArrangedSubview(carbsNutrientView)
    addArrangedSubview(fatsNutrientView)
  }
}
