//
//  ScanResultControllerDelegate.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 22.12.2024.
//

import Foundation

protocol ScanResultControllerDelegate: AnyObject {
  func scanResultControllerDidCancel(_ controller: ScanResultViewController)
  func scanResultController(_ controller: ScanResultViewController, didConfirmMeal meal: Meal)
}
