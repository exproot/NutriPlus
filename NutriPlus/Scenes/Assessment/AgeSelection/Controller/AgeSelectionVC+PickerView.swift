//
//  AgeSelectionVC+PickerView.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 30.12.2024.
//

import UIKit

// MARK: - UIPickerViewDataSource
extension AgeSelectionViewController: UIPickerViewDataSource {
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    1
  }

  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    viewModel.ages.count
  }
}

// MARK: - UIPickerViewDelegate
extension AgeSelectionViewController: UIPickerViewDelegate {
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    "\(viewModel.ages[row])"
  }

  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    viewModel.selectAge(at: row)
  }

  func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
    let label = view as? UILabel ?? UILabel()
    label.textAlignment = .center
    label.layer.cornerRadius = 10
    label.textColor = .black
    label.layer.masksToBounds = true

    if row == pickerView.selectedRow(inComponent: component) {
      label.font = .boldSystemFont(ofSize: 64)
      label.backgroundColor = .systemOrange
      label.textColor = .white
    } else {
      label.font = .systemFont(ofSize: 56)
      label.backgroundColor = .clear
    }

    label.text = "\(viewModel.ages[row])"
    return label
  }

  func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
    100
  }
}
