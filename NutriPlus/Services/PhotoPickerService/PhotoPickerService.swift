//
//  PhotoPickerService.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 22.12.2024.
//

import PhotosUI

final class PhotoPickerService: NSObject {
  weak var delegate: PhotoPickerServiceDelegate?

  func present(on viewController: UIViewController) {
    PhotoPickerPermissionsManager.checkPermissions { [weak self] result in
      guard let self = self else { return }

      switch result {
      case .success:
        DispatchQueue.main.async {
          let pickerController = self.makePickerController()

          viewController.present(pickerController, animated: true)
        }
      case .failure(let error):
        DispatchQueue.main.async {
          self.delegate?.photoPickerService(self, didFailWithError: error)
        }
      }
    }
  }

  private func makePickerController() -> PHPickerViewController {
    var configuration = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
    configuration.filter = .images
    configuration.selectionLimit = 1
    let pickerController = PHPickerViewController(configuration: configuration)
    pickerController.delegate = self
    pickerController.presentationController?.delegate = self
    return pickerController
  }

  private func handleImagePicking(with results: [PHPickerResult]) {
    guard let itemProvider = results.first?.itemProvider else {
      delegate?.photoPickerServiceDidCancel(self)
      return
    }

    itemProvider.loadObject(ofClass: UIImage.self) { [weak self] selectedImage, error in
      DispatchQueue.main.async {
        guard let self = self else { return }

        if let error {
          self.delegate?.photoPickerService(self, didFailWithError: error)
          return
        }

        let selectedImage = selectedImage as? UIImage
        self.delegate?.photoPickerService(self, didSelectImage: selectedImage)
      }
    }
  }
}

// MARK: - PHPickerViewControllerDelegate
extension PhotoPickerService: PHPickerViewControllerDelegate {
  func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
    picker.dismiss(animated: true)
    handleImagePicking(with: results)
  }
}

// MARK: - UIAdaptivePresentationControllerDelegate
extension PhotoPickerService: UIAdaptivePresentationControllerDelegate {
  func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
    delegate?.photoPickerServiceDidCancel(self)
  }
}
