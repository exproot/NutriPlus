//
//  MainTabBarController.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 23.10.2024.
//

import UIKit

final class MainTabBarController: UITabBarController {
  weak var tabBarButtonsDelegate: TabBarButtonsDelegate?

  // MARK: - UI Components
  lazy var cameraOptionButton = CustomButton(imageString: "camera.circle.fill", pointSize: 30, foregroundColor: .systemOrange)
  lazy var manualOptionButton = CustomButton(imageString: "list.bullet.circle.fill", pointSize: 30, foregroundColor: .systemOrange)
  lazy var plusButton: UIButton = {
    var config = UIButton.Configuration.plain()
    config.baseForegroundColor = .systemOrange
    config.image = UIImage(systemName: "plus.circle.fill")?.applyingSymbolConfiguration(.init(pointSize: 40))

    let customButton = UIButton()
    customButton.configuration = config
    return customButton
  }()
  var buttonsVisible = false

  // MARK: - Controller Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    delegate = self
    setupPlusButton()
    setupOptionButtons()
    setupActions()
    setupTabs()
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    setupTabBar()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.navigationBar.isHidden = true
  }

  // MARK: - Methods
  private func setupTabs() {
    view.backgroundColor = .systemBackground
    let homeVC = UINavigationController(rootViewController: HomeViewController())
    let myMealsVC = UINavigationController(rootViewController: MyMealsViewController())

    homeVC.tabBarItem.title = "Home"
    myMealsVC.tabBarItem.title = "My Meals"
    homeVC.tabBarItem.tag = 0
    myMealsVC.tabBarItem.tag = 1
    tabBar.tintColor = .label

    homeVC.tabBarItem.image = UIImage(systemName: "house.fill")
    myMealsVC.tabBarItem.image = UIImage(systemName: "fork.knife")

    setViewControllers([homeVC, myMealsVC], animated: true)
  }
}

// MARK: - UITabBarControllerDelegate
extension MainTabBarController: UITabBarControllerDelegate {
  func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
    if viewController.tabBarItem.tag == 1 {
      plusButton.isHidden = false
    } else {
      plusButton.isHidden = true
      hideOptionButtons()
    }
  }
}
