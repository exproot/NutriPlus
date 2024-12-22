//
//  CameraViewControllerDelegate.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 22.12.2024.
//

import Foundation

protocol CameraViewControllerDelegate: AnyObject {
  func didCancelCapturing(_ controller: CameraViewController)
  func didScanMealWithAI(_ controller: CameraViewController, meal: Meal)
}
