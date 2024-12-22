//
//  CameraSessionProtocol.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 22.12.2024.
//

import AVFoundation
import UIKit

protocol CameraSessionProtocol {
  var session: AVCaptureSession { get }

  func startSession()
  func stopSession()
  func configureSession() throws
  func capturePhoto(delegate: AVCapturePhotoCaptureDelegate)
  func setupPreviewLayer(for view: UIView)
}
