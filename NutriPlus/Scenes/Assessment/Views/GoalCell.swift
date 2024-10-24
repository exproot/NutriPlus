//
//  GoalCell.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 24.10.2024.
//

import UIKit

final class GoalCell: UITableViewCell {
    static let identifier = "GoalCell"
    
    // MARK: - UI Components
    private lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 20, weight: .semibold)
        lbl.textColor = .black
        lbl.text = "⏲️ I wanna lose weight"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private lazy var selectionIndicator: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "square")
        iv.tintColor = .black
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with title: String) {
        titleLabel.text = title
    }
    
    func selectionBehaviour(_ isSelected: Bool) {
        selectionIndicator.image = isSelected ? UIImage(systemName: "dot.square") : UIImage(systemName: "square")
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        self.layer.cornerRadius = 20
        self.backgroundColor = .systemGray4.withAlphaComponent(0.5)
        
        addSubview(titleLabel)
        addSubview(selectionIndicator)
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            
            selectionIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            selectionIndicator.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor, constant: -10),
            selectionIndicator.widthAnchor.constraint(equalToConstant: 25),
            selectionIndicator.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
}
