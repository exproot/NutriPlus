//
//  CameraSessionManager.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 22.12.2024.
//

import AVFoundation
import UIKit

final class CameraSessionManager: CameraSessionProtocol {
  var session = AVCaptureSession()
  private var videoDevice: AVCaptureDevice?
  private var videoInput: AVCaptureDeviceInput?
  private var photoOutput = AVCapturePhotoOutput()

  func startSession() {
    guard !session.isRunning else {
      print("Session is already running.")
      return
    }

    #if targetEnvironment(simulator)
    print("Running on Simulator. Camera session will not start.")
    #else
    DispatchQueue.global(qos: .userInitiated).async { [weak self] in
      guard let self = self else { return }

      self.session.beginConfiguration()

      do {
        try self.configureSession()
      } catch {
        print("Error configuring session: \(error)")
        self.session.commitConfiguration()
        return
      }

      self.session.commitConfiguration()

      self.session.startRunning()
    }
    #endif
  }

  func stopSession() {
    guard session.isRunning else { return }
    session.stopRunning()
    print("Camera session stopped.")
  }

  func configureSession() throws {
    #if targetEnvironment(simulator)
        print("Running on Simulator. Skipping session configuration.")
        return
    #else
        session.inputs.forEach { session.removeInput($0) }
        session.outputs.forEach { session.removeOutput($0) }

        if session.canSetSessionPreset(.photo) {
          session.sessionPreset = .photo
        }

        do {
          try setupInputs()
        } catch {
          print("Error setting up inputs: \(error)")
          return
        }

        setupOutput()

        debugSessionConfiguration()
    #endif
  }

  private func debugSessionConfiguration() {
    print("Session inputs:")
    session.inputs.forEach { input in
      if let deviceInput = input as? AVCaptureDeviceInput {
        print("- \(deviceInput.device.localizedName) (\(deviceInput.device.position.rawValue))")
      }
    }

    print("Session outputs:")
    session.outputs.forEach { output in
      print("- \(output)")
    }
  }

  private func setupInputs() throws {
    guard let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
      throw CameraError.deviceUnavailable
    }
    videoDevice = device

    let input = try AVCaptureDeviceInput(device: device)
    guard session.canAddInput(input) else {
      throw CameraError.unableToAddInput
    }
    session.addInput(input)
    videoInput = input
    print("Camera input added successfully.")
  }

  private func setupOutput() {
    guard session.canAddOutput(photoOutput) else {
      print("Unable to add photo output to the session.")
      return
    }

    session.addOutput(photoOutput)
    print("Photo output added successfully with a video connection.")
  }

  func capturePhoto(delegate: AVCapturePhotoCaptureDelegate) {
    let photoSettings = AVCapturePhotoSettings()
    photoOutput.capturePhoto(with: photoSettings, delegate: delegate)
  }

  func setupPreviewLayer(for view: UIView) {
    let previewLayer = AVCaptureVideoPreviewLayer(session: session)
    previewLayer.videoGravity = .resizeAspectFill
    previewLayer.cornerRadius = 20
    previewLayer.frame = view.bounds
    view.layer.addSublayer(previewLayer)
  }
}
