//
//  MealCell.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 7.11.2024.
//

import UIKit

final class MealCell: UICollectionViewCell {
    static let identifier = "MealCell"
    
    // MARK: - UI Components
    private lazy var iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.tintColor = .systemOrange
        iv.image = UIImage(systemName: "fork.knife.circle.fill")
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private lazy var mealLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 20, weight: .bold)
        lbl.text = "Salad with eggs"
        lbl.textColor = .label
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private lazy var kcalLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 16, weight: .thin)
        lbl.textColor = .systemGray
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private lazy var barStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.alignment = .center
        sv.distribution = .fillEqually
        sv.spacing = 130
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupBars()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with text: String) {
        kcalLabel.text = text
    }
    
    private func createBarView(macro: String, value: Int, color: UIColor) -> UIView {
        let backgroundHeight = CGFloat(50)
        let maxValue = 100
        
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        let valueLabel = UILabel()
        valueLabel.text = "\(value)g"
        valueLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        valueLabel.textAlignment = .center
        valueLabel.textColor = .black
        
        let barHeight = (CGFloat(value) / CGFloat(maxValue)) * backgroundHeight
        
        let barView = UIView()
        barView.backgroundColor = color
        barView.layer.cornerRadius = 4
        barView.translatesAutoresizingMaskIntoConstraints = false
        barView.heightAnchor.constraint(equalToConstant: barHeight).isActive = true
        barView.widthAnchor.constraint(equalToConstant: 10).isActive = true
        
        let barBackgroundView = UIView()
        barBackgroundView.backgroundColor = .lightGray
        barBackgroundView.layer.cornerRadius = 4
        barBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        barBackgroundView.heightAnchor.constraint(equalToConstant: backgroundHeight).isActive = true
        barBackgroundView.widthAnchor.constraint(equalToConstant: 10).isActive = true
        
        barBackgroundView.addSubview(barView)
        NSLayoutConstraint.activate([
            barView.bottomAnchor.constraint(equalTo: barBackgroundView.bottomAnchor),
            barView.leadingAnchor.constraint(equalTo: barBackgroundView.leadingAnchor),
            barView.trailingAnchor.constraint(equalTo: barBackgroundView.trailingAnchor)
        ])
        
        let macroLabel = UILabel()
        macroLabel.text = macro
        macroLabel.font = UIFont.systemFont(ofSize: 18)
        macroLabel.textAlignment = .center
        macroLabel.textColor = .gray
        
        containerView.addSubview(valueLabel)
        containerView.addSubview(barBackgroundView)
        containerView.addSubview(macroLabel)
        
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        barBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        macroLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            barBackgroundView.topAnchor.constraint(equalTo: containerView.topAnchor),
            barBackgroundView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            valueLabel.topAnchor.constraint(equalTo: barBackgroundView.topAnchor, constant: 8),
            valueLabel.leadingAnchor.constraint(equalTo: barBackgroundView.trailingAnchor, constant: 8),
            
            
            macroLabel.bottomAnchor.constraint(equalTo: barBackgroundView.bottomAnchor),
            macroLabel.leadingAnchor.constraint(equalTo: barBackgroundView.trailingAnchor, constant: 8)
        ])
        
        return containerView
    }
    
    // MARK: - UI Setup
    private func setupBars() {
        let proteinBar = createBarView(macro: "Protein", value: 80, color: .systemGreen)
        let fatsBar = createBarView(macro: "Fats", value: 22, color: .systemOrange)
        let carbsBar = createBarView(macro: "Carbs", value: 42, color: .systemYellow)
        
        barStackView.addArrangedSubview(proteinBar)
        barStackView.addArrangedSubview(fatsBar)
        barStackView.addArrangedSubview(carbsBar)
    }
    
    private func setupUI() {
        layer.cornerRadius = 10
        layer.borderWidth = 0.2
        layer.borderColor = UIColor.systemOrange.cgColor
        backgroundColor = .lightGray.withAlphaComponent(0.1)
        
        addSubview(iconImageView)
        addSubview(mealLabel)
        addSubview(kcalLabel)
        addSubview(barStackView)
        
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor, constant: 4),
            iconImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            iconImageView.widthAnchor.constraint(equalToConstant: 40),
            iconImageView.heightAnchor.constraint(equalToConstant: 40),
            
            mealLabel.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor, constant: 4),
            mealLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8),
            
            kcalLabel.topAnchor.constraint(equalTo: mealLabel.bottomAnchor),
            kcalLabel.leadingAnchor.constraint(equalTo: mealLabel.leadingAnchor),
            
            barStackView.topAnchor.constraint(equalTo: kcalLabel.bottomAnchor, constant: 16),
            barStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 28),
            
        ])
    }
}
