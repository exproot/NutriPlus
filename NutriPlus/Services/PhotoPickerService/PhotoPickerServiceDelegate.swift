//
//  PhotoPickerServiceDelegate.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 22.12.2024.
//

import UIKit

protocol PhotoPickerServiceDelegate: AnyObject {
  func photoPickerService(_ photoPickerService: PhotoPickerService, didSelectImage image: UIImage?)
  func photoPickerService(_ photoPickerService: PhotoPickerService, didFailWithError error: Error)
  func photoPickerServiceDidCancel(_ photoPickerService: PhotoPickerService)
}
