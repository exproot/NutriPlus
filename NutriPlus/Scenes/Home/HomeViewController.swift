//
//  HomeViewController.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 23.10.2024.
//

import UIKit

final class HomeViewModel {
  let authService: AuthService

  init(authService: AuthService) {
    self.authService = authService
  }

  func signOut(completion: @escaping (Error?) -> Void) {
    authService.signOut { error in
      if let error {
        completion(error)
        return
      }

      completion(nil)
    }
  }
}

final class HomeViewController: UIViewController {
  lazy var viewModel = HomeViewModel(authService: AuthService())

  private lazy var signOutButton: UIButton = {
    var config = UIButton.Configuration.plain()
    config.title = "Sign Out"
    let btn = UIButton()
    btn.configuration = config
    btn.translatesAutoresizingMaskIntoConstraints = false
    return btn
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    signOutButton.addTarget(self, action: #selector(signOutButtonTapped), for: .touchUpInside)

//    navigationController?.pushViewController(BMIViewController(viewModel: BMIViewModel(assessmentService: AssessmentService(uid: AuthUtils.shared.getCurrentUserUid()))), animated: true)
    navigationController?.pushViewController(BMRViewController(), animated: true)
  }
  
  // MARK: - UI Setup
  private func setupUI() {
    view.backgroundColor = .systemBackground
    view.addSubview(signOutButton)
    
    NSLayoutConstraint.activate([
      signOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      signOutButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
    ])
  }
  
  @objc private func signOutButtonTapped() {
    viewModel.signOut { [weak self] error in
      if let error {
        self?.showAlert(title: "Sign Out Failed", message: error.localizedDescription)
      }
    }
  }
}
