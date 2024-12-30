//
//  BMIStackView.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 29.12.2024.
//

import UIKit

final class BMIStackView: UIStackView {
  // MARK: - UI Components
  private lazy var workoutHelpView = BMIHelpView(text: "Regular workouts can boost your life and keep your body in shape!", imageString: "helpWorkout")
  private lazy var dietHelpView = BMIHelpView(text: "A balanced diet can enhance your quality of life and keep you fit!", imageString: "helpDiet")
  private lazy var trackHelpView = BMIHelpView(text: "Tracking your calories is the key to a healthier lifestyle!", imageString: "helpTracking")

  override init(frame: CGRect) {
    super.init(frame: .zero)
    setupUI()
  }
  
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func configure() {
    axis = .vertical
    distribution = .equalSpacing
    spacing = 35
    translatesAutoresizingMaskIntoConstraints = false
  }

  // MARK: - UI Setup
  private func setupUI() {
    configure()
    [workoutHelpView, dietHelpView, trackHelpView].forEach {
      addArrangedSubview($0)
    }
  }
}
