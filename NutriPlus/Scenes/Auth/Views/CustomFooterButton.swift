//
//  CustomFooterButton.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 21.10.2024.
//

import UIKit

final class CustomFooterButton: UIButton {
    init(title: String, frame: CGRect) {
        super.init(frame: frame)
        setupUI(with: title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    private func setupUI(with title: String) {
        translatesAutoresizingMaskIntoConstraints = false
        addUnderlinedTitle(title: title)
    }
}
