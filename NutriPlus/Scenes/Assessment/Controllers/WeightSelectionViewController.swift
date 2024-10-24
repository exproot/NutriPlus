//
//  WeightSelectionViewController.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 23.10.2024.
//

import UIKit
import Lottie

final class WeightSelectionViewController: BaseAssessmentViewController {
    private var selectedWeight: Float = 62
    private let stepValue: Float = 1
    private var isKg: Bool = true
    
    // MARK: - UI Components
    private let questionLabel = AssessmentTitleLabel(title: "What's your current weight right now?")
    
    private lazy var unitSelector: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Kg", "Lbs"])
        sc.selectedSegmentIndex = 0
        sc.backgroundColor = .white
        sc.selectedSegmentTintColor = .white
        sc.setTitleTextAttributes([.foregroundColor: UIColor.systemOrange], for: .normal)
        sc.translatesAutoresizingMaskIntoConstraints = false
        return sc
    }()
    
    private lazy var weightLabel: UILabel = {
        let label = UILabel()
        label.text = "62 Kg"
        label.font = .systemFont(ofSize: 48, weight: .bold)
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var weightSlider: UISlider = {
        let thumbImage = UIImage(systemName: "square.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        
        let sl = UISlider()
        sl.setThumbImage(thumbImage, for: .normal)
        sl.minimumTrackTintColor = .white
        sl.maximumTrackTintColor = .lightGray
        sl.value = 62
        sl.isContinuous = true
        sl.translatesAutoresizingMaskIntoConstraints = false
        return sl
    }()
    
    private lazy var weightScanAnimationView: LottieAnimationView = {
        let av = LottieAnimationView(name: "WeightScan")
        av.translatesAutoresizingMaskIntoConstraints = false
        return av
    }()
    
    private let continueButton = ContinueButton()
    
    // MARK: - Life Viewcycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupAnimations()
        setupActions()
        updateSliderRange(isKg: true)
        updateWeightLabel()
    }
    
    private func updateSliderRange(isKg: Bool) {
        if isKg {
            weightSlider.minimumValue = 35
            weightSlider.maximumValue = 200
            selectedWeight = selectedWeight.convertToKg()
        } else {
            weightSlider.minimumValue = 75
            weightSlider.maximumValue = 445
            selectedWeight = selectedWeight.convertToLbs()
        }
        
        weightSlider.value = selectedWeight
    }
    
    // MARK: - UI Setup
    private func setupAnimations() {
        weightScanAnimationView.contentMode = .scaleAspectFill
        weightScanAnimationView.loopMode = .loop
        weightScanAnimationView.play()
        
        view.addSubview(weightScanAnimationView)
        
        NSLayoutConstraint.activate([
            weightScanAnimationView.topAnchor.constraint(equalTo: weightSlider.bottomAnchor, constant: 40),
            weightScanAnimationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weightScanAnimationView.heightAnchor.constraint(equalToConstant: 250),
            weightScanAnimationView.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    private func setupActions() {
        weightSlider.addTarget(self, action: #selector(weightSliderChanged(_:)), for: .valueChanged)
        unitSelector.addTarget(self, action: #selector(unitChanged), for: .valueChanged)
        continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
    }
    
    private func updateWeightLabel(toLb: Bool? = nil) {
        let unit = isKg ? "Kg" : "Lbs"
        weightLabel.text = "\(Int(selectedWeight)) \(unit)"
    }
    
    private func setupUI() {
        view.backgroundColor = .systemOrange
        
        view.addSubview(questionLabel)
        view.addSubview(unitSelector)
        view.addSubview(weightLabel)
        view.addSubview(weightSlider)
        view.addSubview(continueButton)
        
        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            questionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            questionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            unitSelector.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 40),
            unitSelector.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            unitSelector.heightAnchor.constraint(equalToConstant: 50),
            unitSelector.widthAnchor.constraint(equalToConstant: 140),
            
            weightLabel.topAnchor.constraint(equalTo: unitSelector.bottomAnchor, constant: 40),
            weightLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            weightSlider.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weightSlider.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            weightSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            weightSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            continueButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    // MARK: - Selectors
    @objc private func unitChanged() {
        isKg = unitSelector.selectedSegmentIndex == 0
        updateSliderRange(isKg: isKg)
        updateWeightLabel()
    }
    
    @objc private func weightSliderChanged(_ sender: UISlider) {
        let roundedValue = round(sender.value / stepValue) * stepValue
        sender.value = roundedValue
        selectedWeight = roundedValue
        updateWeightLabel()
    }
    
    @objc private func continueButtonTapped() {
        assessmentModel.weight = Int(selectedWeight)
        
        let vc = FitSelectionViewController(model: assessmentModel)
        navigationController?.pushViewController(vc, animated: true)
    }
}
