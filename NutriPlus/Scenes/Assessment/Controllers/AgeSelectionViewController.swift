//
//  SelectAgeViewController.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 23.10.2024.
//

import UIKit

final class AgeSelectionViewController: BaseAssessmentViewController {
    private let ages = Array(1...100)
    private var selectedAge: Int = 18
    
    // MARK: - UI Components
    private lazy var agePickerView: UIPickerView = {
        let pv = UIPickerView()
        pv.translatesAutoresizingMaskIntoConstraints = false
        return pv
    }()
    
    private let questionLabel = AssessmentTitleLabel(title: "What's your Age?")
    
    private let continueButton = ContinueButton()
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        agePickerView.delegate = self
        agePickerView.dataSource = self
        
        agePickerView.selectRow(selectedAge - 1, inComponent: 0, animated: false)
        continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(questionLabel)
        view.addSubview(agePickerView)
        view.addSubview(continueButton)
        
        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            questionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            questionLabel.heightAnchor.constraint(equalToConstant: 35),
            
            agePickerView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor),
            agePickerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3),
            agePickerView.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: -20),
            agePickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            continueButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    // MARK: - Selectors
    @objc private func continueButtonTapped() {
        assessmentModel.age = selectedAge
        
        let vc = WeightSelectionViewController(model: assessmentModel)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension AgeSelectionViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        ages.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        "\(ages[row])"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedAge = ages[row]
        pickerView.reloadAllComponents()
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        label.textAlignment = .center
        
        if row == pickerView.selectedRow(inComponent: component) {
            label.font = .boldSystemFont(ofSize: 64)
            label.textColor = .white
            label.backgroundColor = .systemOrange
            label.layer.cornerRadius = 10
            label.layer.masksToBounds = true
        } else {
            label.textColor = .label
            label.font = .systemFont(ofSize: 56)
        }
        
        label.text = "\(ages[row])"
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        100
    }
}
