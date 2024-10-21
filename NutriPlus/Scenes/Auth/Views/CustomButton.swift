//
//  CustomButton.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 21.10.2024.
//

import UIKit

final class CustomButton: UIButton {
    enum ButtonState {
        case normal
        case disabled
    }
    
    private var disabledBackgroundColor: UIColor? = UIColor.label.withAlphaComponent(0.5)
    private var defaultBackgroundColor: UIColor? = UIColor.label {
        didSet {
            backgroundColor = defaultBackgroundColor
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            if isEnabled {
                if let color = defaultBackgroundColor {
                    self.backgroundColor = color
                }
            } else {
                if let color = disabledBackgroundColor {
                    self.backgroundColor = color
                }
            }
        }
    }
    
    init(title: String? = nil, frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        if let title = title {
            setTitle(title, for: .normal)
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        backgroundColor = .label
        setTitleColor(.systemBackground, for: .normal)
        layer.cornerRadius = 20
        translatesAutoresizingMaskIntoConstraints = false
    }
}
