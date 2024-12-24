//
//  ChatViewController+TableView.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 23.12.2024.
//

import UIKit

extension ChatViewController {
  func scrollToBottom() {
    // Get the index of the last row
    let lastRowIndex = viewModel.messages.count - 1

    // Check if the last row is visible
    guard let lastCell = chatTableView.cellForRow(at: IndexPath(row: lastRowIndex, section: 0)) else {
      // If the last cell is not visible, scroll to the bottom
      let indexPath = IndexPath(row: lastRowIndex, section: 0)
      print("scrolling")
      chatTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
      return
    }

    // If the last cell is visible, no need to scroll
    if !chatTableView.bounds.contains(lastCell.frame) {
      // If it's partially out of view, scroll to the bottom
      print("scroll")
      let indexPath = IndexPath(row: lastRowIndex, section: 0)
      chatTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
  }
}
