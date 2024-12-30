//
//  CustomAnimation.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 22.12.2024.
//

import Foundation
import Lottie

final class CustomAnimation: LottieAnimationView {
  init(name: String, loopMode: LottieLoopMode, contentMode: ContentMode = .scaleAspectFit) {
    let animation = LottieAnimation.named(name)
    super.init(animation: animation)
    self.contentMode = contentMode
    setupUI(loopMode: loopMode)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setupUI(loopMode: LottieLoopMode) {
    isUserInteractionEnabled = false
    clipsToBounds = true
    translatesAutoresizingMaskIntoConstraints = false

    self.loopMode = loopMode
  }
}
