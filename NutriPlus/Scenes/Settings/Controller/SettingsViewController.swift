//
//  SettingsViewController.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 8.01.2025.
//

import UIKit

final class SettingsViewController: UIViewController {
  let viewModel: SettingsViewModel
  var tableView: UITableView!

  // MARK: - Controller Lifecycle
  init(viewModel: SettingsViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTableView()
    setupUI()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.navigationBar.isHidden = false
    navigationController?.navigationBar.tintColor = .label
    tabBarController?.tabBar.isHidden = true
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    navigationController?.navigationBar.isHidden = true
    tabBarController?.tabBar.isHidden = false
  }

  // MARK: - UI Setup
  func navigateToChangePasswordController() {
    let controller = ChangePasswordViewController()

    navigationController?.pushViewController(controller, animated: true)
  }

  private func setupUI() {
    title = "Settings"
    view.backgroundColor = .systemBackground
    view.addSubview(tableView)

    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    ])
  }
}
