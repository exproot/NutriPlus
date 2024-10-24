//
//  AssessmentTitleLabel.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 24.10.2024.
//

import UIKit

final class AssessmentTitleLabel: UILabel {
    init(title: String) {
        super.init(frame: .zero)
        self.text = title
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        self.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        self.textAlignment = .center
        self.numberOfLines = 0
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
