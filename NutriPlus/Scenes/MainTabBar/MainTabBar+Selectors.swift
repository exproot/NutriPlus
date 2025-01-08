//
//  MainTabBar+Selectors.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 8.01.2025.
//

import UIKit

// MARK: - Selectors
extension MainTabBarController {
  @objc func cameraOptionButtonTapped() {
    tabBarButtonsDelegate?.didTapCameraOption()
  }

  @objc func manualOptionButtonTapped() {
    tabBarButtonsDelegate?.didTapManualOption()
  }

  @objc func middleButtonPressed(_ sender: UIButton) {
    if buttonsVisible == false {
      sender.transform = CGAffineTransform(rotationAngle: .pi / 4)
      buttonsVisible.toggle()
    } else {
      UIView.animate(withDuration: 0.3) {
        sender.transform = CGAffineTransform(rotationAngle: 0)
        self.buttonsVisible.toggle()
      }
    }

    UIView.animate(withDuration: 0.3) {
      let alpha: CGFloat = self.buttonsVisible ? 1 : 0
      let offset: CGFloat = self.buttonsVisible ? 6 : 0
      self.cameraOptionButton.alpha = alpha
      self.manualOptionButton.alpha = alpha

      self.cameraOptionButton.transform = CGAffineTransform(translationX: -offset, y: 0)
      self.manualOptionButton.transform = CGAffineTransform(translationX: offset, y: 0)
    }
  }
}

extension MainTabBarController {
  func setupActions() {
    plusButton.addTarget(self, action: #selector(middleButtonPressed(_:)), for: .touchUpInside)
    cameraOptionButton.addTarget(self, action: #selector(cameraOptionButtonTapped), for: .touchUpInside)
    manualOptionButton.addTarget(self, action: #selector(manualOptionButtonTapped), for: .touchUpInside)
  }

  func hideOptionButtons() {
    buttonsVisible = false
    UIView.animate(withDuration: 0.3) {
      self.cameraOptionButton.alpha = 0
      self.manualOptionButton.alpha = 0
    }
  }

  func setupOptionButtons() {
    [manualOptionButton, cameraOptionButton].forEach { button in
      tabBar.addSubview(button)
      button.alpha = 0
    }

    NSLayoutConstraint.activate([
      manualOptionButton.centerYAnchor.constraint(equalTo: plusButton.centerYAnchor),
      manualOptionButton.trailingAnchor.constraint(equalTo: plusButton.leadingAnchor, constant: -8),

      cameraOptionButton.centerYAnchor.constraint(equalTo: plusButton.centerYAnchor),
      cameraOptionButton.leadingAnchor.constraint(equalTo: plusButton.trailingAnchor, constant: 8)
    ])
  }

  func setupPlusButton() {
    plusButton.frame = CGRect(x: (self.tabBar.bounds.width / 2) - 25, y: -20, width: 50, height: 50)
    tabBar.addSubview(plusButton)
    plusButton.isHidden = true
  }
}
