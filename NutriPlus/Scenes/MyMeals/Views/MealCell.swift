//
//  MealCell.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 7.11.2024.
//

import UIKit

final class MealCell: UICollectionViewCell {
  static let identifier = "MealCell"

  // MARK: - UI Components
  private lazy var iconImageView: UIImageView = {
    let iv = UIImageView()
    iv.contentMode = .scaleAspectFit
    iv.translatesAutoresizingMaskIntoConstraints = false
    return iv
  }()

  private lazy var mealLabel =  CustomLabel(text: "", fontSize: 20, fontWeight: .bold, textColor: .label)
  private lazy var kcalLabel = CustomLabel(text: "", fontSize: 16, fontWeight: .regular, textColor: .systemGray)
  private lazy var proteinView = NutrientView(title: "Protein", value: 0, color: .systemGreen, imageString: "protein")
  private lazy var carbsView = NutrientView(title: "Carbs", value: 0, color: .systemYellow, imageString: "carbs")
  private lazy var fatsView = NutrientView(title: "Fat", value: 0, color: .systemRed, imageString: "fats")

  private lazy var nutrientStackView: UIStackView = {
    let sv = UIStackView(arrangedSubviews: [proteinView, carbsView, fatsView])
    sv.axis = .vertical
    sv.alignment = .center
    sv.distribution = .equalSpacing
    sv.translatesAutoresizingMaskIntoConstraints = false
    return sv
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configure(with model: MealCellViewModel) {
    iconImageView.image = UIImage(named: model.type.lowercased())
    mealLabel.text = model.name
    kcalLabel.text = "\(model.calories)kcal"
    configureProgressViews(
      protein: Float(model.protein),
      carbs: Float(model.carbs),
      fat: Float(model.fat)
    )
  }

  private func configureProgressViews(protein: Float, carbs: Float, fat: Float) {
    let totalGrams =  protein + carbs + fat

    proteinView.amountLabel.text = "\(Int(protein))g"
    carbsView.amountLabel.text = "\(Int(carbs))g"
    fatsView.amountLabel.text = "\(Int(fat))g"

    proteinView.progressView.setProgress(protein / totalGrams, animated: false)
    carbsView.progressView.setProgress(carbs / totalGrams, animated: false)
    fatsView.progressView.setProgress(fat / totalGrams, animated: false)
  }

  // MARK: - UI Setup
  private func setupUI() {
    layer.cornerRadius = 10
    backgroundColor = .lightGray.withAlphaComponent(0.1)

    addSubview(iconImageView)
    addSubview(mealLabel)
    addSubview(kcalLabel)
    addSubview(nutrientStackView)

    NSLayoutConstraint.activate([
      iconImageView.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor, constant: 4),
      iconImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
      iconImageView.widthAnchor.constraint(equalToConstant: 40),
      iconImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.2),

      kcalLabel.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor),
      kcalLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),

      mealLabel.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor),
      mealLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8),

      nutrientStackView.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 4),
      nutrientStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.85),
      nutrientStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      nutrientStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
    ])
  }
}
