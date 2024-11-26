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
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        setupWindow(with: scene)
        UserDefaults.resetDefaults()
        
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
        window?.makeKeyAndVisible()
    }
    
    func checkAuthentication() {
        handle = Auth.auth().addStateDidChangeListener({ [weak self] auth, user in
            if user != nil {
                StoreService.shared.checkFirstLogin(for: user!.uid) { result in
                    guard let result = result else { fatalError() }
                    
                    self?.navigateToController(result ? MainTabBarController() : AgeSelectionViewController(model: AssessmentModel()))
                }
            } else {
                self?.navigateToController(SignInViewController())
            }
        })
        
        //        if let currentUser = Auth.auth().currentUser {
        //            StoreService.shared.checkFirstLogin(for: currentUser.uid) { [weak self] result in
        //                guard let result = result else { fatalError() }
        //
        //                self?.navigateToController(result ? MainTabBarController() : AgeSelectionViewController(model: AssessmentModel()))
        //            }
        //        } else {
        //            navigateToController(SignInViewController())
        //        }
    }
    
    func navigateToController(_ controller: UIViewController) {
        let nc = UINavigationController(rootViewController: controller)
        window?.rootViewController = nc
    }
}

