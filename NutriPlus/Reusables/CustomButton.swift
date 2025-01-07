//
//  CustomButton.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 24.10.2024.
//

import UIKit

final class CustomButton: UIButton {
  
  /// Filled button with only an image.
  /// - Parameters:
  ///   - isSystemImage: Describing if button's image is system image or not.
  ///   - imageString: Image string describing button's image.
  ///   - backgroundColor: Button's base background color.
  ///   - foregroundColor: Button's base foreground color.
  ///   - cornerStyle: Button's corner style defaults to medium.
  init(isSystemImage: Bool, imageString: String, backgroundColor: UIColor, foregroundColor: UIColor, cornerStyle: UIButton.Configuration.CornerStyle = .medium) {
    super.init(frame: .zero)
    translatesAutoresizingMaskIntoConstraints = false

    var config = UIButton.Configuration.filled()
    config.image = isSystemImage ? UIImage(systemName: imageString) : UIImage(named: imageString)
    config.baseBackgroundColor = backgroundColor
    config.baseForegroundColor = foregroundColor
    config.cornerStyle = cornerStyle
    self.configuration = config
  }

  /// Filled button with a title.
  /// - Parameters:
  ///   - title: Button's title.
  ///   - backgroundColor: Button's base background color defaults to black.
  ///   - foregroundColor: Button's base foreground color defaults to white.
  ///   - cornerStyle: Button's corner style defaults to medium.
  init(title: String = "Continue", backgroundColor: UIColor = .black, foregroundColor: UIColor = .white, cornerStyle: UIButton.Configuration.CornerStyle = .medium) {
    super.init(frame: .zero)
    translatesAutoresizingMaskIntoConstraints = false

    var config = UIButton.Configuration.filled()
    config.title = title
    config.baseBackgroundColor = backgroundColor
    config.baseForegroundColor = foregroundColor
    config.cornerStyle = cornerStyle
    self.configuration = config
  }
  
  /// Filled button with title and image.
  /// - Parameters:
  ///   - imageString: Image string describing button's image.
  ///   - title: Button's title.
  ///   - subtitle: Button's subtitle.
  ///   - backgroundColor: Button's base background color defaults to systemFill.
  ///   - foregroundColor: Button's base foreground color defaults to label.
  ///   - cornerStyle: Button's corner style defaults to medium.
  init(imageString: String, title: String, subtitle: String, backgroundColor: UIColor = .systemFill,  foregroundColor: UIColor = .label, cornerStyle: UIButton.Configuration.CornerStyle = .medium) {
    super.init(frame: .zero)
    translatesAutoresizingMaskIntoConstraints = false

    var config = UIButton.Configuration.filled()
    config.title = title
    config.subtitle = subtitle
    config.image = UIImage(systemName: imageString)
    config.imagePadding = 10
    config.titlePadding = 5
    config.cornerStyle = cornerStyle
    self.configuration = config
  }

  /// Plain button with an image.
  /// - Parameters:
  ///   - imageString: Image string describing button's image.
  ///   - foregroundColor: Button's foreground color, defaults to white.
  ///   - cornerStyle: Button's corner style, defaults to medium.
  init(imageString: String, foregroundColor: UIColor = .white, cornerStyle: UIButton.Configuration.CornerStyle = .medium) {
    super.init(frame: .zero)
    translatesAutoresizingMaskIntoConstraints = false

    var config = UIButton.Configuration.plain()
    config.baseForegroundColor = foregroundColor
    config.cornerStyle = cornerStyle
    config.image = UIImage(systemName: imageString)
    self.configuration = config
  }

  
  /// Plain button with an image.
  /// - Parameters:
  ///   - imageString: Image string describing button's image.
  ///   - pointSize: Image's point size.
  ///   - foregroundColor: Button's foreground color defaults to white.
  init(imageString: String, pointSize: CGFloat, foregroundColor: UIColor = .white) {
    super.init(frame: .zero)
    translatesAutoresizingMaskIntoConstraints = false

    var config = UIButton.Configuration.plain()
    config.baseForegroundColor = foregroundColor
    config.cornerStyle = .medium
    config.image = UIImage(systemName: imageString)?.applyingSymbolConfiguration(.init(pointSize: pointSize))
    self.configuration = config
  }
  
  /// Plain Button with a title.
  /// - Parameters:
  ///   - title: Button's title.
  ///   - foregroundColor: Button's foreground color defaults to label.
  init(title: String, foregroundColor: UIColor = .label) {
    super.init(frame: .zero)
    translatesAutoresizingMaskIntoConstraints = false

    var config = UIButton.Configuration.plain()
    config.baseForegroundColor = foregroundColor
    config.title = title
    self.configuration = config
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
