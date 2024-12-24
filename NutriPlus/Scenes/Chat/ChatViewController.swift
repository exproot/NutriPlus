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
  lazy var chatTableView: UITableView = {
    let customTable = UITableView()
    customTable.translatesAutoresizingMaskIntoConstraints = false
    customTable.separatorStyle = .none
    customTable.allowsSelection = false
    customTable.register(MessageCell.self, forCellReuseIdentifier: MessageCell.reuseIdentifier)
    return customTable
  }()
  private lazy var inputContainerView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  lazy var textField: UITextField = {
    let textField = UITextField()
    textField.placeholder = "Type a message"
    textField.clipsToBounds = true
    textField.borderStyle = .roundedRect
    textField.returnKeyType = .send
    textField.spellCheckingType = .no
    textField.autocorrectionType = .no
    textField.translatesAutoresizingMaskIntoConstraints = false
    return textField
  }()
  lazy var sendButton: UIButton = {
    let button = UIButton()
    button.setTitle("Send", for: .normal)
    button.backgroundColor = .systemOrange
    button.layer.cornerRadius = 5
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()

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
    setupUI()
    configureNavigationBar()
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

  // MARK: - UI Setup
  private func configureNavigationBar() {
    navigationItem.titleView = navTitleView
  }

  private func setupUI() {
    view.backgroundColor = .systemBackground
    chatTableView.rowHeight = UITableView.automaticDimension
    chatTableView.estimatedRowHeight = 100
    view.addSubview(chatTableView)
    view.addSubview(inputContainerView)
    inputContainerView.addSubview(textField)
    inputContainerView.addSubview(sendButton)

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

    sendButton.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
  }
}
