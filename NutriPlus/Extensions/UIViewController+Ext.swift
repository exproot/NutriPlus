//
//  UIViewController+Ext.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 13.11.2024.
//

import UIKit

extension UIViewController {
  /// Present an alert on the controller.
  /// - Parameters:
  ///   - title: Alert's title.
  ///   - message: Alert message.
  func showAlert(title: String, message: String) {
    let alertVC = UIAlertController(
      title: title,
      message: message,
      preferredStyle: .alert
    )
    alertVC.addAction(.init(title: "Okay", style: .cancel))
    self.present(alertVC, animated: true)
  }

  /// Call the Authentication Listener on the SceneDelegate.
  func checkAuthViaSceneDelegate() {
    if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
      sceneDelegate.checkAuthentication()
    }
  }
}
