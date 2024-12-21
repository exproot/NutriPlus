//
//  AddNewMealStackView.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 20.12.2024.
//

import UIKit

final class AddNewMealStackView: UIStackView {
  private var calorieSlider: MacroSliderView!
  private var proteinSlider: MacroSliderView!
  private var carbsSlider: MacroSliderView!
  private var fatsSlider: MacroSliderView!

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupSliderStackView()
  }

  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - UI Setup
  private func setupSliderStackView() {
    calorieSlider = MacroSliderView(title: "Total Calories", imageString: "calorie", sliderMinValue: 0, sliderMaxValue: 2000, sliderColor: .systemOrange, sliderType: .calorie)
    proteinSlider = MacroSliderView(title: "Total Protein", imageString: "protein", sliderMinValue: 0, sliderMaxValue: 30, sliderColor: .systemGreen, sliderType: .nutrient)
    carbsSlider = MacroSliderView(title: "Total Carbs", imageString: "carbs", sliderMinValue: 0, sliderMaxValue: 30, sliderColor: .systemYellow, sliderType: .nutrient)
    fatsSlider = MacroSliderView(title: "Total Fat", imageString: "fats", sliderMinValue: 0, sliderMaxValue: 30, sliderColor: .systemRed, sliderType: .nutrient)

    addArrangedSubview(calorieSlider)
    addArrangedSubview(proteinSlider)
    addArrangedSubview(carbsSlider)
    addArrangedSubview(fatsSlider)
    axis = .vertical
    distribution = .equalSpacing
    translatesAutoresizingMaskIntoConstraints = false
  }
}
