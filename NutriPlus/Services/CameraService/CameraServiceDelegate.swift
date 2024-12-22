//
//  CameraServiceDelegate.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 22.12.2024.
//

import UIKit

// MARK: - CameraServiceDelegate
protocol CameraServiceDelegate: AnyObject {
  func cameraService(didCaptureImage image: UIImage?)
  func cameraService(didFailWithError error: Error)
  func cameraServiceDidStartCapturingPhoto(_ cameraService: CameraService)
}
