//
//  GenderSelectionViewController.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 23.10.2024.
//

import UIKit

final class GenderSelectionViewController: BaseAssessmentViewController {
    enum Gender {
        case male, female, none
    }
    
    var selectedGender: Gender = .none
    
    // MARK: - UI Components
    private let titleLabel = AssessmentTitleLabel(title: "What is your gender?")
    
    private lazy var maleSelectionView: GenderView = {
        let view = GenderView(image: UIImage(named: "male")!, gender: "♂️Male")
        return view
    }()
    
    private lazy var femaleSelectionView: GenderView = {
        let view = GenderView(image: UIImage(named: "female")!, gender: "♀️Female")
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution = .fillEqually
        sv.spacing = 20
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private let continueButton = ContinueButton()
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureGenderViews()
        setupButtons()
    }
    
    // MARK: - UI Setup
    private func setupButtons() {
        continueButton.isEnabled = false
        continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
    }
    
    private func configureGenderViews() {
        let maleTapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapMale))
        maleSelectionView.addGestureRecognizer(maleTapGesture)
        
        let femaleTapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapFemale))
        femaleSelectionView.addGestureRecognizer(femaleTapGesture)
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(stackView)
        stackView.addArrangedSubview(maleSelectionView)
        stackView.addArrangedSubview(femaleSelectionView)
        view.addSubview(continueButton)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.heightAnchor.constraint(equalToConstant: 300),
            
            continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            continueButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    // MARK: - Selectors
    @objc private func didTapMale() {
        selectedGender = .male
        continueButton.isEnabled = true
        maleSelectionView.isSelectedOption = true
        femaleSelectionView.isSelectedOption = false
    }
    
    @objc private func didTapFemale() {
        selectedGender = .female
        continueButton.isEnabled = true
        maleSelectionView.isSelectedOption = false
        femaleSelectionView.isSelectedOption = true
    }
    
    @objc private func continueButtonTapped() {
        assessmentModel.gender = maleSelectionView.isSelectedOption ? true : false
        
        let vc = GoalSelectionViewController(model: assessmentModel)
        navigationController?.pushViewController(vc, animated: true)
    }
}
