//
//  MessageCell.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 23.12.2024.
//

import UIKit

final class MessageCell: UITableViewCell {
  static let reuseIdentifier = "MessageCell"

  // MARK: - UI Components
  private lazy var messageLabel: UILabel = {
    let customLabel = UILabel()
    customLabel.textColor = .label
    customLabel.font = .systemFont(ofSize: 16, weight: .regular)
    customLabel.numberOfLines = 0
    customLabel.translatesAutoresizingMaskIntoConstraints = false
    return customLabel
  }()

  private let bubbleView: UIView = {
    let view = UIView()
    view.layer.cornerRadius = 16
    view.layer.masksToBounds = true
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  private var bubbleViewLeadingConstraint: NSLayoutConstraint?
  private var bubbleViewTrailingConstraint: NSLayoutConstraint?

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configure(with message: Message) {
    messageLabel.text = message.text
    bubbleView.backgroundColor = message.isSentByUser ? UIColor.systemOrange : UIColor.secondarySystemBackground
    messageLabel.textColor = message.isSentByUser ? .systemBackground : .label
    updateConstraintsForSender(message.isSentByUser)
  }

  // MARK: - UI Setup
  private func updateConstraintsForSender(_ isUserMessage: Bool) {
    if isUserMessage {
      bubbleViewLeadingConstraint?.isActive = false
      bubbleViewTrailingConstraint?.isActive = true
    } else {
      bubbleViewTrailingConstraint?.isActive = false
      bubbleViewLeadingConstraint?.isActive = true
    }
  }

  private func setupUI() {
    contentView.addSubview(bubbleView)
    bubbleView.addSubview(messageLabel)

    NSLayoutConstraint.activate([
      bubbleView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
      bubbleView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
      bubbleView.widthAnchor.constraint(lessThanOrEqualTo: contentView.widthAnchor, multiplier: 0.75),

      messageLabel.topAnchor.constraint(equalTo: bubbleView.topAnchor, constant: 8),
      messageLabel.leadingAnchor.constraint(equalTo: bubbleView.leadingAnchor, constant: 12),
      messageLabel.trailingAnchor.constraint(equalTo: bubbleView.trailingAnchor, constant: -12),
      messageLabel.bottomAnchor.constraint(equalTo: bubbleView.bottomAnchor, constant: -8)
    ])

    bubbleViewLeadingConstraint = bubbleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
    bubbleViewTrailingConstraint = bubbleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)

    bubbleViewLeadingConstraint?.isActive = true
  }
}
