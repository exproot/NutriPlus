//
//  CameraImageView.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 22.12.2024.
//

import UIKit

final class CameraImageView: UIImageView {
  init(imageNamed: String) {
    super.init(frame: .zero)
    self.image = UIImage(named: imageNamed)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - UI Setup
  private func setupUI() {
    translatesAutoresizingMaskIntoConstraints = false
    contentMode = .scaleAspectFill
  }
}
