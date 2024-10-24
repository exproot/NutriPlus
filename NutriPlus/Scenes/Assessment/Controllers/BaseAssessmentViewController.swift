//
//  BaseAssessmentViewController.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 24.10.2024.
//

import UIKit

class BaseAssessmentViewController: UIViewController {
    var assessmentModel: AssessmentModel
    
    init(model: AssessmentModel) {
        self.assessmentModel = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
