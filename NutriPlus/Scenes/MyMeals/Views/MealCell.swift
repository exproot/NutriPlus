//
//  MealCell.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 7.11.2024.
//

import UIKit

protocol MealCellDelegate: AnyObject {
  func didTapOnDelete(for meal: MealCellViewModel?)
  func didTapOnInfo(for meal: MealCellViewModel?)
}

final class MealCell: UICollectionViewCell {
  static let identifier = "MealCell"
  weak var delegate: MealCellDelegate?
  var meal: MealCellViewModel?

  // MARK: - UI Components
  lazy var optionsButton = CustomButton(imageString: "ellipsis.circle", foregroundColor: .systemGray2)
  private lazy var mealLabel =  CustomLabel(text: "", fontSize: 20, fontWeight: .bold, textColor: .label, numberOfLines: 2)
  private lazy var proteinView = NutrientView(title: "Protein", value: 0, color: .systemGreen, imageString: "protein")
  private lazy var carbsView = NutrientView(title: "Carbs", value: 0, color: .systemYellow, imageString: "carbs")
  private lazy var fatsView = NutrientView(title: "Fat", value: 0, color: .systemRed, imageString: "fats")
  private lazy var calorieView = NutrientView(title: "Calorie", value: 0, color: .systemOrange, imageString: "calorie")

  private lazy var nutrientStackView: UIStackView = {
    let sv = UIStackView(arrangedSubviews: [proteinView, carbsView, fatsView, calorieView])
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
    self.meal = model
    mealLabel.text = model.name
    configureProgressViews(
      protein: Float(model.protein),
      carbs: Float(model.carbs),
      fat: Float(model.fat),
      calories: model.calories
    )
  }

  private func configureProgressViews(protein: Float, carbs: Float, fat: Float, calories: Int) {
    let totalGrams =  protein + carbs + fat

    proteinView.amountLabel.text = "\(Int(protein))g"
    carbsView.amountLabel.text = "\(Int(carbs))g"
    fatsView.amountLabel.text = "\(Int(fat))g"
    calorieView.amountLabel.text = "\(calories)kcal"

    proteinView.progressView.setProgress(protein / totalGrams, animated: false)
    carbsView.progressView.setProgress(carbs / totalGrams, animated: false)
    fatsView.progressView.setProgress(fat / totalGrams, animated: false)
    calorieView.progressView.setProgress(Float(calories), animated: false)
  }

  // MARK: - Selectors
  @objc private func optionsButtonTapped() {
    let infoAction = UIAction(title: "Get Info on Nutri AI", image: UIImage(systemName: "info.circle.fill")) { [weak self] _ in
      self?.delegate?.didTapOnInfo(for: self?.meal)
    }

    let deleteAction = UIAction(title: "Delete Meal", image: UIImage(systemName: "trash")?.withTintColor(.systemRed, renderingMode: .alwaysOriginal)) { [weak self] _ in
      self?.delegate?.didTapOnDelete(for: self?.meal)
    }

    let menu = UIMenu(title: "Options", children: [infoAction, deleteAction])
    optionsButton.menu = menu
    optionsButton.showsMenuAsPrimaryAction = true
  }

  // MARK: - UI Setup
  private func setupUI() {
    layer.cornerRadius = 16
    backgroundColor = .lightGray.withAlphaComponent(0.1)
    
    contentView.addSubview(mealLabel)
    contentView.addSubview(optionsButton)
    contentView.addSubview(nutrientStackView)

    NSLayoutConstraint.activate([
      mealLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor, constant: 8),
      mealLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor, constant: 8),
      mealLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8),

      nutrientStackView.topAnchor.constraint(equalTo: mealLabel.bottomAnchor, constant: 8),
      nutrientStackView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.85),
      nutrientStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
      nutrientStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),

      optionsButton.centerYAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor, constant: 16),
      optionsButton.leadingAnchor.constraint(equalTo: mealLabel.trailingAnchor, constant: 4),
      optionsButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.15),
      optionsButton.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.15)
    ])

    optionsButton.addTarget(self, action: #selector(optionsButtonTapped), for: .touchUpInside)
  }
}
