//
//  HomeVC+Selectors.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 10.01.2025.
//

import Foundation

// MARK: - Selectors
extension HomeViewController {
  @objc func handleSettingsButton() {
    guard let assessmentData = viewModel.userHealthData else { return }
    let controller = SettingsViewController(viewModel: SettingsViewModel(authService: AuthService(), assessmentData: assessmentData))

    navigationController?.pushViewController(controller, animated: true)
  }

  func setupActions() {
    profileHeaderView.settingsButton.addTarget(self, action: #selector(handleSettingsButton), for: .touchUpInside)
  }
}
