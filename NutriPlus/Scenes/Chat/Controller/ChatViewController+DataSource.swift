//
//  ChatViewController+DataSource.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 24.12.2024.
//

import UIKit

extension ChatViewController {
  enum Section {
    case main
  }

  func setupDataSource() {
    dataSource = UITableViewDiffableDataSource<Section, Message>(tableView: chatTableView) { (tableView, indexPath, message) -> UITableViewCell? in
      guard let cell = tableView.dequeueReusableCell(withIdentifier: MessageCell.reuseIdentifier, for: indexPath) as? MessageCell else { fatalError("error dequeueing MessageCell") }
      cell.configure(with: message)
      return cell
    }
  }

  func applyInitialSnapshot() {
    var snapshot = NSDiffableDataSourceSnapshot<Section, Message>()
    snapshot.appendSections([.main])
    dataSource.apply(snapshot, animatingDifferences: false)
  }

  func updateSnapshot(with messages: [Message]) {
    var snapshot = dataSource.snapshot()
    snapshot.deleteAllItems()
    snapshot.appendSections([.main])
    snapshot.appendItems(messages)
    dataSource.apply(snapshot, animatingDifferences: true)
    scrollToBottom()
  }
}
