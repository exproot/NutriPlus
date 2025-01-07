//
//  CustomImageView.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 30.12.2024.
//

import UIKit

final class CustomImageView: UIImageView {
  init(image: UIImage?, contentMode: ContentMode) {
    super.init(frame: .zero)
    self.image = image
    self.contentMode = contentMode
    clipsToBounds = true
    translatesAutoresizingMaskIntoConstraints = false
  }

  init(imageString: String, contentMode: ContentMode, imageTintColor: UIColor) {
    super.init(image: UIImage(named: imageString)?.withTintColor(imageTintColor, renderingMode: .alwaysOriginal))
    clipsToBounds = true
    self.contentMode = contentMode
    translatesAutoresizingMaskIntoConstraints = false
  }

  init(contentMode: ContentMode = .scaleAspectFill) {
    super.init(frame: .zero)
    clipsToBounds = true
    self.contentMode = contentMode
    translatesAutoresizingMaskIntoConstraints = false
  }

  init(isSystemImage: Bool, imageString: String, contentMode: ContentMode = .scaleAspectFill) {
    super.init(image: isSystemImage ? UIImage(systemName: imageString) : UIImage(named: imageString))
    clipsToBounds = true
    self.contentMode = contentMode
    translatesAutoresizingMaskIntoConstraints = false
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
