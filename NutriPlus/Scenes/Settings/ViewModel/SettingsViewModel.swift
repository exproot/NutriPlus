//
//  SettingsViewModel.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 9.01.2025.
//

import Foundation

final class SettingsViewModel {
  private let authService: AuthServiceProtocol
  private let assessmentData: AssessmentModel
  private var user: NutriUser?

  var accountSettings: [SettingsCellViewModel] = [
    SettingsCellViewModel(imageString: "envelope.fill", title: "Email"),
    SettingsCellViewModel(imageString: "key.fill", title: "Password")
  ]

  var personalSettings: [SettingsCellViewModel] = [
    SettingsCellViewModel(imageString: "calendar", title: "Age"),
    SettingsCellViewModel(imageString: "lines.measurement.horizontal", title: "Weight"),
    SettingsCellViewModel(imageString: "lines.measurement.vertical", title: "Height"),
    SettingsCellViewModel(imageString: "dumbbell.fill", title: "Fit Level")
  ]
  
  // MARK: - Lifecycle
  init(authService: AuthServiceProtocol, assessmentData: AssessmentModel) {
    self.authService = authService
    self.assessmentData = assessmentData
    getUserDetails()
    updatePersonalSettingsModels()
  }

  // MARK: - Methods
  func updatePersonalSettingsModels() {
    personalSettings[0].secondaryText = "\(assessmentData.age ?? 1)"
    personalSettings[1].secondaryText = "\(assessmentData.weight ?? 0) kg"
    personalSettings[2].secondaryText = "\(assessmentData.height ?? 0) cm"
    personalSettings[3].secondaryText = ActivityLevel(rawValue: assessmentData.fitLevel ?? 0)?.description
  }

  func updateAccountSettingsModels() {
    if let email = user?.email {
      accountSettings[0].secondaryText = email
    }
  }

  func logOutCurrentUser() {
    authService.signOut { error in
      if let error = error {
        print(error)
        return
      }
    }
  }

  func getUserDetails() {
    self.user = authService.getSignedUser()
    updateAccountSettingsModels()
  }

  func numberOfItems(in section: Int) -> Int {
    guard let section = SettingsSection(rawValue: section) else { return 0 }
    switch section {
    case .account:
      return accountSettings.count
    case .personal:
      return personalSettings.count
    case .logout:
      return 1
    }
  }

  func cellViewModel(for indexPath: IndexPath) -> SettingsCellViewModel? {
    guard let section = SettingsSection(rawValue: indexPath.section) else { return nil }
    switch section {
    case .account:
      return accountSettings[indexPath.row]
    case .personal:
      return personalSettings[indexPath.row]
    case .logout:
      return nil
    }
  }

  func titleForHeader(in section: Int) -> String? {
    guard let section = SettingsSection(rawValue: section) else { return nil }

    return section.sectionHeaderText
  }
}
