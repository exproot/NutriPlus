//
//  CameraButton.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 22.12.2024.
//

import UIKit

final class CameraButton: UIButton {
  init(imageString: String, pointSize: CGFloat) {
    super.init(frame: .zero)
    var config = UIButton.Configuration.plain()
    config.baseForegroundColor = .white
    config.cornerStyle = .medium
    config.image = UIImage(systemName: imageString)?.applyingSymbolConfiguration(.init(pointSize: pointSize))

    configuration = config
    translatesAutoresizingMaskIntoConstraints = false
  }

  init(title: String) {
    super.init(frame: .zero)
    var config = UIButton.Configuration.plain()
    config.baseForegroundColor = .white
    config.cornerStyle = .medium
    config.title = title

    configuration = config
    translatesAutoresizingMaskIntoConstraints = false
  }

  init(title: String, color: UIColor) {
    super.init(frame: .zero)
    var config = UIButton.Configuration.plain()
    config.baseForegroundColor = color
    config.title = title

    configuration = config
    translatesAutoresizingMaskIntoConstraints = false
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
