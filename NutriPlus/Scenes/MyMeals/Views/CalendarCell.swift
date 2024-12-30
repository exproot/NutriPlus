//
//  CalendarCell.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 7.11.2024.
//

import UIKit

final class CalendarCell: UICollectionViewCell {
  static let identifier = String(describing: CalendarCell.self)

  // MARK: - UI Components
  lazy var monthLabel = CustomLabel(text: "", fontSize: 22, fontWeight: .bold, textColor: .label)
  lazy var dayNumberLabel = CustomLabel(text: "", fontSize: 20, fontWeight: .bold, textColor: .secondaryLabel)

  // MARK: - Lifecycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Methods
  func configure(dateString: String) {
    let yearMonthAndDay = dateString.components(separatedBy: "-")
    if let month = Int(yearMonthAndDay[1]) {
      monthLabel.text = DateFormatter()
        .shortMonthSymbols[month - 1]
    }

    dayNumberLabel.text = yearMonthAndDay[2]
  }

  // MARK: - UI Setup
  private func setupUI() {
    let grayView = UIView(frame: bounds)
    grayView.backgroundColor = .lightGray.withAlphaComponent(0.1)
    grayView.layer.cornerRadius = 10
    self.backgroundView = grayView


    let orangeView = UIView(frame: bounds)
    orangeView.backgroundColor = .systemOrange
    orangeView.layer.cornerRadius = 10
    self.selectedBackgroundView = orangeView

    addSubview(monthLabel)
    addSubview(dayNumberLabel)

    NSLayoutConstraint.activate([
      monthLabel.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor, constant: 4),
      monthLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),

      dayNumberLabel.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor, constant: -4),
      dayNumberLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
    ])
  }
}
