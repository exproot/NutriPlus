//
//  CustomModalHeaderView.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 7.01.2025.
//

import UIKit

final class CustomModalHeaderView: UIView {
  // MARK: - UI Components
  lazy var cancelButton = CustomButton(title: "Cancel", foregroundColor: .systemRed)
  lazy var doneButton = CustomButton(title: "Done", foregroundColor: .label)
  private lazy var titleLabel = CustomLabel(text: "", fontSize: 16, fontWeight: .bold, textColor: .label)

  private lazy var seperatorView: UIView = {
    let customView = UIView()
    customView.backgroundColor = .systemFill
    customView.translatesAutoresizingMaskIntoConstraints = false
    return customView
  }()

  init(title: String) {
    super.init(frame: .zero)
    self.titleLabel.text = title
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - UI Setup
  private func setupUI() {
    translatesAutoresizingMaskIntoConstraints = false
    addSubview(titleLabel)
    addSubview(cancelButton)
    addSubview(doneButton)
    addSubview(seperatorView)

    NSLayoutConstraint.activate([
      cancelButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      cancelButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),

      doneButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      doneButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),

      titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),

      seperatorView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
      seperatorView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      seperatorView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      seperatorView.heightAnchor.constraint(equalToConstant: 1)
    ])
  }
}
