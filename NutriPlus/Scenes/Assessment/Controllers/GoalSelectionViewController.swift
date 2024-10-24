//
//  GoalSelectionViewController.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 24.10.2024.
//

import UIKit
import FirebaseAuth

final class GoalSelectionViewController: BaseAssessmentViewController {
    lazy var viewModel = GoalSelectionViewModel()
    
    // MARK: - UI Components
    private let titleLabel = AssessmentTitleLabel(title: "What is your main \n goal/target?")
    
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.register(GoalCell.self, forCellReuseIdentifier: GoalCell.identifier)
        tv.separatorStyle = .none
        tv.isScrollEnabled = false
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    private let continueButton = ContinueButton()
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupButtons()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    // MARK: - UI Setup
    private func setupButtons() {
        continueButton.isEnabled = false
        continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(tableView)
        view.addSubview(continueButton)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: -40),
            
            continueButton.heightAnchor.constraint(equalToConstant: 50),
            continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    // MARK: - Selectors
    @objc private func continueButtonTapped() {
        // TODO: - Implement
        print(assessmentModel)
        if let currentUser = Auth.auth().currentUser {
            StoreService.shared.setAssessment(for: currentUser.uid)
            
            if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                sceneDelegate.checkAuthentication()
            }
        }
    }
}

extension GoalSelectionViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.fitnessGoals.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        4
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        " "
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        65
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GoalCell.identifier, for: indexPath) as? GoalCell else { fatalError() }
        cell.configure(with: viewModel.fitnessGoals[indexPath.section])
        let backgroundView = UIView()
        backgroundView.layer.cornerRadius = 20
        backgroundView.backgroundColor = UIColor.systemOrange
        cell.selectedBackgroundView = backgroundView
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        continueButton.isEnabled = true
        guard let cell = tableView.cellForRow(at: indexPath) as? GoalCell else { fatalError() }
        cell.selectionBehaviour(cell.isSelected)
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? GoalCell else { fatalError() }
        cell.selectionBehaviour(cell.isSelected)
    }
}
