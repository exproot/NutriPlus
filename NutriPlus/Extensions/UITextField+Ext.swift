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
    ///   - padding: Padding for the image.
    ///   - isLeftView: Boolean value that defines that image's placement on the text field.
    ///   - isConfirmation: An optional value indicates that text field is a password confirmation text field.
    func addIconWithPadding(_ imageString: String, padding: CGFloat, isLeftView: Bool, isConfirmation: Bool? = nil) {
        if let isConfirmation = isConfirmation {
            if isConfirmation {
                self.subviews.forEach { view in
                    if view.tag == 29 {
                        view.removeFromSuperview()
                    }
                }
            }
        }
        
        let frame = CGRect(x: 0, y: 0, width: 30 + padding, height: 30)
        
        let containerView = UIView(frame: frame)
        containerView.tag = 29
        let iconView = UIImageView(frame: frame)
        
        iconView.image = UIImage(systemName: imageString)
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
