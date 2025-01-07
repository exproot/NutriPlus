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
    setupTabs()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.navigationBar.isHidden = true
  }

  private func setupTabs() {
    view.backgroundColor = .systemBackground
    let homeVC = UINavigationController(rootViewController: HomeViewController())
    let myMealsVC = UINavigationController(rootViewController: MyMealsViewController())

    homeVC.tabBarItem.title = "Home"
    myMealsVC.tabBarItem.title = "My Meals"
    tabBar.tintColor = .label

    homeVC.tabBarItem.image = UIImage(systemName: "house.fill")
    myMealsVC.tabBarItem.image = UIImage(systemName: "fork.knife")

    setViewControllers([homeVC, myMealsVC], animated: true)
  }
}
