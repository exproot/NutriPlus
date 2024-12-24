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
  private lazy var captureCoverView: UIView = {
    let customView = UIView()
    customView.translatesAutoresizingMaskIntoConstraints = false
    customView.layer.cornerRadius = 20
    return customView
  }()
  var photoPreviewView: PhotoPreviewView?
  private lazy var cancelButton = CameraButton(imageString: "multiply", pointSize: 20)
  private lazy var galleryButton = CameraButton(imageString: "photo", pointSize: 20)
  lazy var barScannerAnimation = CameraAnimation(name: "BarScanner", loopMode: .loop)
  private lazy var platePlaceholderImageView = CameraImageView(imageNamed: "Plate-Placeholder")
  private lazy var takePhotoButton = CameraButton(imageString: "button.programmable", pointSize: 50)

  // MARK: - Controller Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.cameraService.delegate = self
    viewModel.photoPickerService.delegate = self
    viewModel.geminiService.imageScanDelegate = self
    setupUI()

    viewModel.$takePhotoButtonEnabled
      .assign(to: \.isEnabled, on: takePhotoButton)
      .store(in: &cancellables)

    viewModel.$takePhotoButtonEnabled
      .assign(to: \.isEnabled, on: galleryButton)
      .store(in: &cancellables)

    viewModel.$takePhotoButtonEnabled
      .assign(to: \.isEnabled, on: cancelButton)
      .store(in: &cancellables)
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    viewModel.startCameraSession()
    viewModel.cameraService.setupPreviewLayer(for: captureCoverView)
  }

  // MARK: - UI Setup
  func presentScanResultController(with meal: Meal) {
    let scanResultVC = ScanResultViewController(meal: meal)
    scanResultVC.delegate = self
    scanResultVC.isModalInPresentation = true

    if let sheet = scanResultVC.sheetPresentationController {
      sheet.detents = [.medium()]
    }

    navigationController?.present(scanResultVC, animated: true)
  }

  func setupImagePreviewView(with image: UIImage?) {
    photoPreviewView = PhotoPreviewView(frame: captureCoverView.frame)

    if let photoPreviewView {
      photoPreviewView.imageView.image = image
      view.insertSubview(photoPreviewView, belowSubview: barScannerAnimation)
    }
  }

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

    cancelButton.addTarget(self, action: #selector(handleCancelButton(_ :)), for: .touchUpInside)
    galleryButton.addTarget(self, action: #selector(handleGalleryButton(_ :)), for: .touchUpInside)
    takePhotoButton.addTarget(self, action: #selector(handleCaptureImage), for: .touchUpInside)
  }
}
