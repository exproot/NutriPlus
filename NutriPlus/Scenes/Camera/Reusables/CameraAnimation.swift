//
//  CameraAnimation.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 22.12.2024.
//

import Foundation
import Lottie

final class CameraAnimation: LottieAnimationView {
  init(name: String, loopMode: LottieLoopMode) {
    let animation = LottieAnimation.named(name)
    super.init(animation: animation)
    setupUI(loopMode: loopMode)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setupUI(loopMode: LottieLoopMode) {
    isUserInteractionEnabled = false
    contentMode = .scaleAspectFit
    clipsToBounds = true
    translatesAutoresizingMaskIntoConstraints = false

    self.loopMode = loopMode
  }
}
