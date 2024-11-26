//
//  UIViewController+Ext.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 13.11.2024.
//

import UIKit

extension UIViewController {
    /// Call the Authentication Listener on the SceneDelegate.
    func checkAuthViaSceneDelegate() {
        if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
            sceneDelegate.checkAuthentication()
        }
    }
}
