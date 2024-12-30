//
//  CameraViewController.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 22.12.2024.
//

import UIKit
import Combine

final class CameraViewController: UIViewController {
  lazy var viewModel = CameraViewModel(
    cameraService: CameraService(cameraSession: CameraSessionManager()),
    photoPickerService: PhotoPickerService(),
    geminiService: GeminiService()
  )
  weak var delegate: CameraViewControllerDelegate?
  private var cancellables: Set<AnyCancellable> = []

  // MARK: - UI Components
  lazy var captureCoverView: UIView = {
    let customView = UIView()
    customView.translatesAutoresizingMaskIntoConstraints = false
    customView.layer.cornerRadius = 20
    return customView
  }()
  var photoPreviewView: PhotoPreviewView?
  lazy var cancelButton = CustomButton(imageString: "multiply", pointSize: 20)
  lazy var galleryButton = CustomButton(imageString: "photo", pointSize: 20)
  lazy var barScannerAnimation = CustomAnimation(name: "BarScanner", loopMode: .loop)
  lazy var platePlaceholderImageView = CustomImageView(isSystemImage: false, imageString: "Plate-Placeholder", contentMode: .scaleAspectFill)
  lazy var takePhotoButton = CustomButton(imageString: "button.programmable", pointSize: 50)

  // MARK: - Controller Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.cameraService.delegate = self
    viewModel.photoPickerService.delegate = self
    viewModel.geminiService.imageScanDelegate = self
    setupUI()
    setupConstraints()
    setupActions()
    setupBindings()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    viewModel.startCameraSession()
    viewModel.cameraService.setupPreviewLayer(for: captureCoverView)
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    tabBarController?.tabBar.isHidden = true
  }

  private func setupBindings() {
    viewModel.$takePhotoButtonIsEnabled
      .receive(on: DispatchQueue.main)
      .sink { [weak self] state in
        self?.takePhotoButton.isEnabled = state
        self?.galleryButton.isEnabled = state
        self?.cancelButton.isEnabled = state
      }
      .store(in: &cancellables)
  }
}

// MARK: - UI Setup
extension CameraViewController {
  private func setupUI() {
    view.backgroundColor = .black
    navigationItem.hidesBackButton = true
    platePlaceholderImageView.alpha = 0.2
    view.addSubview(captureCoverView)
    view.addSubview(cancelButton)
    view.addSubview(galleryButton)
    view.addSubview(platePlaceholderImageView)
    view.addSubview(takePhotoButton)
    view.addSubview(barScannerAnimation)
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      captureCoverView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      captureCoverView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80),
      captureCoverView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      captureCoverView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

      cancelButton.topAnchor.constraint(equalTo: captureCoverView.topAnchor, constant: 12),
      cancelButton.leadingAnchor.constraint(equalTo: captureCoverView.leadingAnchor, constant: 12),

      galleryButton.topAnchor.constraint(equalTo: captureCoverView.topAnchor, constant: 12),
      galleryButton.trailingAnchor.constraint(equalTo: captureCoverView.trailingAnchor, constant: -12),

      barScannerAnimation.centerXAnchor.constraint(equalTo: captureCoverView.centerXAnchor),
      barScannerAnimation.centerYAnchor.constraint(equalTo: captureCoverView.centerYAnchor),

      platePlaceholderImageView.centerYAnchor.constraint(equalTo: captureCoverView.centerYAnchor),
      platePlaceholderImageView.centerXAnchor.constraint(equalTo: captureCoverView.centerXAnchor),
      platePlaceholderImageView.widthAnchor.constraint(equalTo: captureCoverView.widthAnchor, multiplier: 0.65),
      platePlaceholderImageView.heightAnchor.constraint(equalTo: captureCoverView.heightAnchor, multiplier: 0.35),

      takePhotoButton.bottomAnchor.constraint(equalTo: captureCoverView.bottomAnchor, constant: -20),
      takePhotoButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
    ])
  }
}
