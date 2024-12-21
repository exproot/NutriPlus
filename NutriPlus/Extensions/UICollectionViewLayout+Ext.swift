//
//  UICollectionViewLayout+Ext.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 21.12.2024.
//

import UIKit

extension UICollectionViewLayout {
  static func createMealTypeLayout() -> UICollectionViewFlowLayout {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    layout.itemSize = CGSize(width: 120, height: 40)
    return layout
  }
}
