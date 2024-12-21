//
//  AddNewMealHeaderView.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 18.12.2024.
//

import UIKit

protocol AddNewMealHeaderDelegate: AnyObject {
  func addNewMealHeaderView(_ view: AddNewMealHeaderView, didSwitchSegment segmentIndex: Int)
}

final class AddNewMealHeaderView: UIView {
  weak var delegate: AddNewMealHeaderDelegate?

  // MARK: - UI Components
  private lazy var titleLabel = CustomLabel(text: "Add New Meal", fontSize: 28, fontWeight: .bold, textColor: .white)
  lazy var segmentedControl: UISegmentedControl = {
    let segmentedControl = UISegmentedControl(items: ["Manual", "AI Scan"])
    segmentedControl.selectedSegmentIndex = 0
    segmentedControl.backgroundColor = .black.withAlphaComponent(0.1)
    segmentedControl.selectedSegmentTintColor = .systemBackground
    segmentedControl.setTitleTextAttributes(
      [.foregroundColor: UIColor.label, .font: UIFont.systemFont(ofSize: 14, weight: .semibold)],
      for: .selected
    )
    segmentedControl.setTitleTextAttributes(
      [.foregroundColor: UIColor.secondaryLabel, .font: UIFont.systemFont(ofSize: 14, weight: .semibold)],
      for: .normal
    )
    segmentedControl.layer.cornerRadius = 10
    segmentedControl.clipsToBounds = true
    segmentedControl.translatesAutoresizingMaskIntoConstraints = false
    return segmentedControl
  }()

  // MARK: - View Lifecycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - UI Setup
  private func setupUI() {
    backgroundColor = .systemOrange
    layer.cornerRadius = 35
    translatesAutoresizingMaskIntoConstraints = false

    addSubview(titleLabel)
    addSubview(segmentedControl)

    NSLayoutConstraint.activate([
      titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -16),
      titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),

      segmentedControl.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
      segmentedControl.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      segmentedControl.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.75),
      segmentedControl.heightAnchor.constraint(equalToConstant: 45),
    ])

    segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
  }

  // MARK: - Selectors
  @objc private func segmentedControlValueChanged(_ sender: UISegmentedControl) {
    delegate?.addNewMealHeaderView(self, didSwitchSegment: segmentedControl.selectedSegmentIndex)
  }
}
