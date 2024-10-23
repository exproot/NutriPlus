//
//  MainTabBarController.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 23.10.2024.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createTabBar()
    }
    
    private func createTabBar() {
        view.backgroundColor = .systemBackground
        let homeVC = UINavigationController(rootViewController: HomeViewController(authService: AuthService()))
        
        homeVC.tabBarItem.title = "Home"
        tabBar.tintColor = .label
        
        homeVC.tabBarItem.image = UIImage(systemName: "house.fill")
        
        setViewControllers([homeVC], animated: true)
    }
}
