//
//  SceneDelegate.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 21.10.2024.
//

import UIKit
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?
  weak var handle: AuthStateDidChangeListenerHandle?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    setupWindow(with: scene)

    if (UserDefaults.standard.value(forKey: "openedApp") as? Bool) == nil {
      navigateToController(OnboardingViewController())
    } else {
      checkAuthentication()
    }
  }

  private func setupWindow(with scene: UIScene) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    window = UIWindow(frame: windowScene.coordinateSpace.bounds)
    window?.windowScene = windowScene
  }

  func checkAuthentication() {
    handle = Auth.auth().addStateDidChangeListener({ [weak self] auth, user in
      if let user = user {
        FirestoreUtils.shared.checkFirstLogin(for: user.uid) { result in
          guard let result = result else { fatalError() }

          self?.navigateToController(result ? MainTabBarController() : AgeSelectionViewController(model: AssessmentModel()))
        }
      } else {
        self?.navigateToController(SignInViewController())
      }
    })
  }

  func navigateToController(_ controller: UIViewController) {
    let nc = UINavigationController(rootViewController: controller)
    window?.rootViewController = nc
    window?.makeKeyAndVisible()
  }
}

