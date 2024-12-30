//
//  ChatViewController.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 23.12.2024.
//

import UIKit
import Combine

final class ChatViewController: KeyboardHandlingViewController {
  lazy var viewModel = ChatViewModel(geminiService: GeminiService())
  var dataSource: UITableViewDiffableDataSource<Section, Message>!
  var inputContainerBottomConstraint: NSLayoutConstraint!
  private var cancellables: Set<AnyCancellable> = []

  // MARK: - UI Components
  lazy var navTitleView = ChatNavigationTitleStackView()
  var chatTableView = UITableView()
  private lazy var inputContainerView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  lazy var textField = CustomTextField(placeholder: "Type a message", borderStyle: .roundedRect, returnKeyType: .send, spellCheckingType: .no, autoCorrectionType: .no)
  lazy var sendButton = CustomButton(title: "Send", backgroundColor: .systemOrange)

  // MARK: - Controller Lifecycle
  init(with message: String) {
    super.init(nibName: nil, bundle: nil)
    viewModel.sendMessage(message)
  }

  init() {
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    textField.delegate = self
    setupTableView()
    setupUI()
    setupConstraints()
    configureNavigationBar()
    setupActions()
    setupDataSource()
    applyInitialSnapshot()
    setupBindings()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    tabBarController?.tabBar.isHidden = true
    let appearance = UINavigationBarAppearance()
    appearance.backgroundColor = .systemGroupedBackground
    navigationController?.navigationBar.scrollEdgeAppearance = appearance
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    tabBarController?.tabBar.isHidden = false
    navigationController?.navigationBar.scrollEdgeAppearance = nil
  }

  // MARK: - Methods
  private func setupBindings() {
    viewModel.$messages
      .receive(on: DispatchQueue.main)
      .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
      .sink { [weak self] messages in
        self?.updateSnapshot(with: messages)
      }
      .store(in: &cancellables)
  }
}

// MARK: - UI Setup
extension ChatViewController {
  private func configureNavigationBar() {
    navigationItem.titleView = navTitleView
  }

  private func setupUI() {
    view.backgroundColor = .systemBackground
    view.addSubview(chatTableView)
    view.addSubview(inputContainerView)
    inputContainerView.addSubview(textField)
    inputContainerView.addSubview(sendButton)
  }

  private func setupConstraints() {
    inputContainerBottomConstraint = inputContainerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)

    NSLayoutConstraint.activate([
      inputContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      inputContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      inputContainerView.heightAnchor.constraint(equalToConstant: 50),
      inputContainerBottomConstraint,

      textField.centerYAnchor.constraint(equalTo: inputContainerView.centerYAnchor),
      textField.leadingAnchor.constraint(equalTo: inputContainerView.leadingAnchor, constant: 16),
      textField.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor, multiplier: 0.74),
      textField.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: 0.8),

      sendButton.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: 4),
      sendButton.trailingAnchor.constraint(equalTo: inputContainerView.trailingAnchor, constant: -16),
      sendButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
      sendButton.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: 0.8),

      chatTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      chatTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      chatTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      chatTableView.bottomAnchor.constraint(equalTo: inputContainerView.topAnchor),
    ])
  }
}
