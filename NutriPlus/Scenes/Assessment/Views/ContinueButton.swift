//
//  ContinueButton.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 24.10.2024.
//

import UIKit

final class ContinueButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        
        var config = UIButton.Configuration.filled()
        config.title = "Continue"
        config.baseBackgroundColor = .black
        config.cornerStyle = .medium
        self.configuration = config
    }
}
