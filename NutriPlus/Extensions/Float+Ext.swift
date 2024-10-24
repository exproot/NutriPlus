//
//  Float+Ext.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 23.10.2024.
//

import Foundation

extension Float {
    func convertToLbs() -> Float {
        self * 2.20462
    }
    
    func convertToKg() -> Float {
        self * 0.453592
    }
}
