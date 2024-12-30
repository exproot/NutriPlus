//
//  NutrientView.swift
//  practice
//
//  Created by Ertan Yağmur on 17.12.2024.
//

import UIKit

final class NutrientView: UIView {
  // MARK: - UI Components
  private lazy var imageView: UIImageView = {
    let customImageView = UIImageView()
    customImageView.contentMode = .scaleAspectFit
    customImageView.clipsToBounds = true
    customImageView.translatesAutoresizingMaskIntoConstraints = false
    return customImageView
  }()
  private var titleLabel: CustomLabel
  var amountLabel: CustomLabel
  lazy var progressView: UIProgressView = {
    let progressView = UIProgressView(progressViewStyle: .default)
    progressView.translatesAutoresizingMaskIntoConstraints = false
    return progressView
  }()

  init(title: String, value: Float, color: UIColor, imageString: String) {
    titleLabel = CustomLabel(text: title, fontSize: 16, fontWeight: .semibold, textColor: .label)
    amountLabel = CustomLabel(text: "22g", fontSize: 12, fontWeight: .regular, textColor: .secondaryLabel)
    super.init(frame: .zero)
    progressView.progress = value
    progressView.tintColor = color
    imageView.image = UIImage(named: imageString)
    setupUI()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - UI Setup
  private func setupUI() {
    addSubview(imageView)
    addSubview(titleLabel)
    addSubview(amountLabel)
    addSubview(progressView)

    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: self.topAnchor),
      imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      imageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.1),
      imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),

      titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
      titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 12),

      amountLabel.topAnchor.constraint(equalTo: self.topAnchor),
      amountLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),

      progressView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
      progressView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 12),
      progressView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      progressView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.1)
    ])
  }
}
