//
//  TransparentView.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 1.01.2025.
//

import UIKit

final class TransparentView: UIView {
  private lazy var title = CustomLabel(text: "", fontSize: 12, fontWeight: .semibold, textColor: .white)

  init(text: String) {
    super.init(frame: .zero)
    translatesAutoresizingMaskIntoConstraints = false
    title.text = text
    setupUI()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - UI Setup
  private func setupUI() {
    backgroundColor = .systemGray.withAlphaComponent(0.35)

    addSubview(title)

    NSLayoutConstraint.activate([
      title.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      title.centerYAnchor.constraint(equalTo: self.centerYAnchor),
    ])
  }
}
