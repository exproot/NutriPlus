//
//  MyMealsViewController.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 7.11.2024.
//

import UIKit

final class MyMealsViewController: UIViewController {
  lazy var viewModel = MyMealsViewModel(mealService: MealService(uid: AuthUtils.shared.getCurrentUserUid()))
  var dataSource: UICollectionViewDiffableDataSource<Section, AnyHashable>!
  var collectionView: UICollectionView!

  // MARK: - UI Comp
  lazy var plusButton = CustomButton(imageString: "plus.circle.fill", pointSize: 35, foregroundColor: .systemOrange)
  lazy var cameraOptionButton = CustomButton(imageString: "camera.circle.fill", pointSize: 25, foregroundColor: .systemOrange)
  lazy var manualOptionButton = CustomButton(imageString: "list.bullet.circle.fill", pointSize: 25, foregroundColor: .systemOrange)
  var buttonsVisible = false

  // MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    configureNavigationBar()
    setupCollectionView()
    configureDataSource()
    applyInitialSnapshot()
    setupPlusButton()
    setupOptionButtons()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    guard let selectedIndex = viewModel.selectedIndex else { return }
    let selectedDate = viewModel.dateItems[selectedIndex].dateString

    viewModel.fetchMeals(for: selectedDate) { [weak self] in
      let indexPath = IndexPath(item: selectedIndex, section: 0)

      self?.updateMealSection()
      self?.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
    }
  }
}

// MARK: - UI Setup
extension MyMealsViewController {
  private func setupOptionButtons() {
    [manualOptionButton, cameraOptionButton].forEach { button in
      view.addSubview(button)
      button.alpha = 0
    }

    NSLayoutConstraint.activate([
      manualOptionButton.centerYAnchor.constraint(equalTo: plusButton.centerYAnchor, constant: -20),
      manualOptionButton.trailingAnchor.constraint(equalTo: plusButton.leadingAnchor),

      cameraOptionButton.centerYAnchor.constraint(equalTo: plusButton.centerYAnchor, constant: -20),
      cameraOptionButton.leadingAnchor.constraint(equalTo: plusButton.trailingAnchor)
    ])

    cameraOptionButton.addTarget(self, action: #selector(cameraOptionButtonTapped), for: .touchUpInside)
    manualOptionButton.addTarget(self, action: #selector(manualOptionButtonTapped), for: .touchUpInside)
  }


  private func setupPlusButton() {
    view.addSubview(plusButton)

    NSLayoutConstraint.activate([
      plusButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      plusButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 20)
    ])

    plusButton.addTarget(self, action: #selector(plusButtonTapped(_:)), for: .touchUpInside)
  }


  func pushChatController(with message: String) {
    let chatController = ChatViewController(with: message)
    navigationController?.pushViewController(chatController, animated: true)
  }

  private func configureNavigationBar() {
    title = "My Meals"
  }

  private func setupUI() {
    view.backgroundColor = .systemBackground
  }
}
