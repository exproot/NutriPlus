//
//  UITextField+Ext.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 21.10.2024.
//

import UIKit.UITextField

extension UITextField {
    /// Add an image to the UITextField with desired padding.
    /// - Parameters:
    ///   - image: Image that is going to be added.
    ///   - padding: Padding for image.
    ///   - isLeftView: Boolean value that defines that image's placement on the text field.
    func addIconWithPadding(_ image: UIImage, padding: CGFloat, isLeftView: Bool) {
        let frame = CGRect(x: 0, y: 0, width: 30 + padding, height: 30)
        
        let containerView = UIView(frame: frame)
        let iconView = UIImageView(frame: frame)
        
        iconView.image = image
        iconView.contentMode = .scaleAspectFit
        iconView.clipsToBounds = true
        iconView.tintColor = .label
        containerView.addSubview(iconView)
        
        if isLeftView {
            leftViewMode = .always
            leftView = containerView
        } else {
            rightViewMode = .always
            rightView = containerView
        }
    }
}
