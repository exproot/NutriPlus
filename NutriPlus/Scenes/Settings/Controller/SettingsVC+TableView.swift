//
//  SettingsVC+TableView.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 10.01.2025.
//

import UIKit

// MARK: - UITableViewDelegate
extension SettingsViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)

    guard let section = SettingsSection(rawValue: indexPath.section) else { return }

    switch section {
    case .account:
      handleAccountSettingsSelection(at: indexPath.row)
    case .personal:
      handlePersonalSettingsSelection(at: indexPath.row)
    case .logout:
      handleLogout()
    }
  }

  private func handleAccountSettingsSelection(at row: Int) {
    switch row {
    case 1:
      navigateToChangePasswordController()
    default:
      break
    }
  }

  private func handlePersonalSettingsSelection(at row: Int) {

  }

  private func handleLogout() {
    viewModel.logOutCurrentUser()
  }
}

// MARK: - UITableViewDataSource
extension SettingsViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    SettingsSection.allCases.count
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    viewModel.numberOfItems(in: section)
  }

  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    viewModel.titleForHeader(in: section)
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath)
    var config = cell.defaultContentConfiguration()

    if let model = viewModel.cellViewModel(for: indexPath) {
      config.text = model.title
      config.image = UIImage(systemName: model.imageString)?.withTintColor(.systemGray2, renderingMode: .alwaysOriginal)
      config.secondaryText = model.secondaryText
      config.prefersSideBySideTextAndSecondaryText = true
    } else {
      config.text = "Log Out"
      config.image = UIImage(systemName: "rectangle.portrait.and.arrow.right")?.withTintColor(.systemRed, renderingMode: .alwaysOriginal)
    }

    cell.contentConfiguration = config
    return cell
  }
}

extension SettingsViewController {
  func setupTableView() {
    tableView = UITableView(frame: .zero, style: .insetGrouped)
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SettingsCell")
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.dataSource = self
    tableView.delegate = self
  }
}
