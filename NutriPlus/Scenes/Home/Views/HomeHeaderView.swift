//
//  HomeHeaderView.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 2.01.2025.
//

import UIKit

final class HomeHeaderView: UICollectionReusableView {
  static let identifier = "HomeHeaderView"

  lazy var title = CustomLabel(text: "", fontSize: 16, fontWeight: .bold, textColor: .label)

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configure(_ text: String) {
    title.text = text
  }

  // MARK: - UI Setup
  private func setupUI() {
    addSubview(title)

    NSLayoutConstraint.activate([
      title.topAnchor.constraint(equalTo: self.topAnchor),
      title.bottomAnchor.constraint(equalTo: self.bottomAnchor),
      title.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      title.trailingAnchor.constraint(equalTo: self.trailingAnchor)
    ])
  }
}
