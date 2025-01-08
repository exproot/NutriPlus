//
//  GoalSelectionVC+TableView.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 30.12.2024.
//

import UIKit

// MARK: - UITableViewDelegate
extension GoalSelectionViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    viewModel.selectGoal(at: indexPath.section)
  }
}

// MARK: - UITableViewDataSource
extension GoalSelectionViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    viewModel.fitnessGoals.count
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    1
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if let screen = view.window?.windowScene?.screen {
      return (screen.bounds.height - 100) / 12
    }

    return 65
  }

  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    let footerView = UIView()
    footerView.backgroundColor = .white
    return footerView
  }

  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    10
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: GoalCell.identifier, for: indexPath) as? GoalCell else { fatalError("error dequeueing GoalCell") }

    let goal = viewModel.fitnessGoals[indexPath.section]
    let isSelected = goal == viewModel.selectedGoal
    cell.configure(with: goal, isSelected: isSelected)

    return cell
  }
}

extension GoalSelectionViewController {
  func configureTableView() {
    tableView.separatorStyle = .none
    tableView.isScrollEnabled = false
    tableView.register(GoalCell.self, forCellReuseIdentifier: GoalCell.identifier)
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.dataSource = self
    tableView.delegate = self
  }
}
