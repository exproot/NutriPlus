//
//  PhotoPreviewView.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 22.12.2024.
//

import UIKit

final class PhotoPreviewView: UIView {
  // MARK: - UI Components
  lazy var imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.layer.cornerRadius = 20
    imageView.clipsToBounds = true
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
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
    backgroundColor = .black
    addSubview(imageView)

    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: self.topAnchor),
      imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
      imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
    ])
  }
}
