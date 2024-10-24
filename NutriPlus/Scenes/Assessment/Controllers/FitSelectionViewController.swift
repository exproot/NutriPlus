//
//  FitSelectionViewController.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 23.10.2024.
//

import UIKit
import Lottie

final class FitSelectionViewController: BaseAssessmentViewController {
    // MARK: - UI Components
    private let questionLabel = AssessmentTitleLabel(title: "How would you rate your fitness level?")
    
    let fitnessLevelLabel: UILabel = {
        let label = UILabel()
        label.text = "3" // Default value
        label.font = UIFont.systemFont(ofSize: 80, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let fitnessDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Somewhat Athletic"
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let slider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 1
        slider.maximumValue = 5
        slider.value = 3 // Default value
        slider.tintColor = .systemOrange
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    private lazy var fitSelectionAnimationView: LottieAnimationView = {
        let av = LottieAnimationView(name: "FitLevel")
        av.translatesAutoresizingMaskIntoConstraints = false
        return av
    }()
    
    private let continueButton = ContinueButton()
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupAnimations()
        setupButtons()
    }
    
    // MARK: - UI Setup
    private func setupButtons() {
        slider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
    }
    
    private func setupAnimations() {
        fitSelectionAnimationView.contentMode = .scaleAspectFill
        fitSelectionAnimationView.loopMode = .loop
        fitSelectionAnimationView.play()
        
        view.addSubview(fitSelectionAnimationView)
        
        
        NSLayoutConstraint.activate([
            fitSelectionAnimationView.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: 40),
            fitSelectionAnimationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            fitSelectionAnimationView.heightAnchor.constraint(equalToConstant: 250),
            fitSelectionAnimationView.widthAnchor.constraint(equalToConstant: 150),
        ])
    }
    
    func updateFitnessDescription(for value: Int) {
        switch value {
        case 1:
            fitnessDescriptionLabel.text = "Sedentary"
        case 2:
            fitnessDescriptionLabel.text = "Lightly Active"
        case 3:
            fitnessDescriptionLabel.text = "Somewhat Athletic"
        case 4:
            fitnessDescriptionLabel.text = "Athletic"
        case 5:
            fitnessDescriptionLabel.text = "Very Athletic"
        default:
            fitnessDescriptionLabel.text = "Unknown"
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(questionLabel)
        view.addSubview(fitnessLevelLabel)
        view.addSubview(fitnessDescriptionLabel)
        view.addSubview(slider)
        view.addSubview(continueButton)
        
        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            questionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            questionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            fitnessLevelLabel.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 40),
            fitnessLevelLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            fitnessDescriptionLabel.topAnchor.constraint(equalTo: fitnessLevelLabel.bottomAnchor, constant: 10),
            fitnessDescriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            slider.topAnchor.constraint(equalTo: fitnessDescriptionLabel.bottomAnchor, constant: 40),
            slider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            slider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
            continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            continueButton.widthAnchor.constraint(equalToConstant: 200),
            continueButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    // MARK: - Selectors
    @objc private func sliderValueChanged(_ sender: UISlider) {
        let value = round(sender.value)
        sender.value = value // Snap to integer values
        
        fitnessLevelLabel.text = "\(Int(value))"
        updateFitnessDescription(for: Int(value))
    }
    
    @objc private func continueButtonTapped() {
        assessmentModel.fitLevel = Int(slider.value)
        
        let vc = GenderSelectionViewController(model: assessmentModel)
        navigationController?.pushViewController(vc, animated: true)
    }
}
