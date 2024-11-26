//
//  CalendarCell.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 7.11.2024.
//

import UIKit

final class CalendarCell: UICollectionViewCell {
    static let identifier = String(describing: CalendarCell.self)
    
//    override var isSelected: Bool {
////        didSet {
////            switch isSelected {
////            case true:
////                backgroundColor = .systemOrange
////                monthLabel.textColor = .systemBackground
////                dayNumberLabel.textColor = .systemBackground
////            case false:
////                backgroundColor = .lightGray.withAlphaComponent(0.1)
////                monthLabel.textColor = .label
////                dayNumberLabel.textColor = .secondaryLabel
////            }
////        }
//    }
    
    // MARK: - UI Components
    lazy var monthLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 22, weight: .bold)
        lbl.textColor = .label
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var dayNumberLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 20, weight: .bold)
        lbl.textColor = .secondaryLabel
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(day: String, month: String) {
        if let month = Int(month) {
            monthLabel.text = DateFormatter()
                .shortMonthSymbols[month - 1]
        }
        
        dayNumberLabel.text = day
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        let grayView = UIView(frame: bounds)
        grayView.backgroundColor = .lightGray.withAlphaComponent(0.1)
        grayView.layer.cornerRadius = 10
        self.backgroundView = grayView
        
        
        let orangeView = UIView(frame: bounds)
        orangeView.backgroundColor = .systemOrange
        orangeView.layer.cornerRadius = 10
        self.selectedBackgroundView = orangeView
        
        
        addSubview(monthLabel)
        addSubview(dayNumberLabel)
        
        NSLayoutConstraint.activate([
            monthLabel.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor, constant: 4),
            monthLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            dayNumberLabel.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor, constant: -4),
            dayNumberLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
}
