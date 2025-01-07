//
//  CalorieStatsVC+TableView.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 7.01.2025.
//

import UIKit

// MARK: - UITableViewDataSource
extension CalorieStatsViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    3
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: MacronutrientCell.reuseIdentifier, for: indexPath) as? MacronutrientCell else { fatalError("error dequeueing MacronutrientCell") }
    cell.configure(type: MacronutrientType(rawValue: indexPath.row) ?? .protein, amount: viewModel.macronutrientAmounts[indexPath.row])
    return cell
  }
}


// MARK: - UITableViewDelegate
extension CalorieStatsViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    80
  }
}

extension CalorieStatsViewController {
  func setupTableView() {
    macronutrientsTableView = UITableView(frame: .zero, style: .insetGrouped)
    macronutrientsTableView.delegate = self
    macronutrientsTableView.dataSource = self
    macronutrientsTableView.allowsSelection = false
    macronutrientsTableView.backgroundColor = .systemBackground
    macronutrientsTableView.translatesAutoresizingMaskIntoConstraints = false
    macronutrientsTableView.register(MacronutrientCell.self, forCellReuseIdentifier: MacronutrientCell.reuseIdentifier)
  }
}
