//
//  UIButton+Ext.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 21.10.2024.
//

import UIKit.UIButton

extension UIButton {
    /// Add an underlined title to the UIButton with provided string.
    /// - Parameter title: Button's title
    func addUnderlinedTitle(title: String) {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 14),
            .foregroundColor: UIColor.systemOrange,
            .underlineColor: UIColor.systemOrange,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        
        let attributedTitle = NSMutableAttributedString(string: title, attributes: attributes)
        self.setAttributedTitle(attributedTitle, for: .normal)
    }
}
