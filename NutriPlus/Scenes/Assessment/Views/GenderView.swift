//
//  GenderView.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 23.10.2024.
//

import UIKit

final class GenderView: UIView {
    var isSelectedOption: Bool = false {
        didSet {
            updateSelectionState()
        }
    }
    
    // MARK: - UI Components
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 15
        iv.layer.borderWidth = 1.5
        iv.layer.borderColor = UIColor.label.withAlphaComponent(0.4).cgColor
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private lazy var  genderLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 20, weight: .bold)
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
    
    init(image: UIImage, gender: String) {
        super.init(frame: .zero)
        setupView(image: image, gender: gender)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateSelectionState() {
        let imageName = isSelectedOption ? "dot.square" : "square"
        selectionIndicator.image = UIImage(systemName: imageName)
        imageView.layer.borderColor = isSelectedOption ? UIColor.systemOrange.withAlphaComponent(0.4).cgColor : UIColor.label.withAlphaComponent(0.4).cgColor
    }
    
    // MARK: - UI Setup
    private func setupView(image: UIImage, gender: String) {
        translatesAutoresizingMaskIntoConstraints = false
        imageView.image = image
        genderLabel.text = gender
        
        addSubview(imageView)
        addSubview(genderLabel)
        addSubview(selectionIndicator)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            genderLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            genderLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            
            selectionIndicator.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            selectionIndicator.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            selectionIndicator.widthAnchor.constraint(equalToConstant: 30),
            selectionIndicator.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}
