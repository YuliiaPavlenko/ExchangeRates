//
//  CurrencyDetailsViewElements.swift
//  ExchangeRatesTestTask
//
//  Created by Yuliia Pavlenko on 17/04/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import UIKit

class CurrencyDetailsViewElements {

    static func createDateTextField() -> UITextField {
        let dateTextField = UITextField()
        dateTextField.font = UIFont.systemFont(ofSize: 15)
        dateTextField.borderStyle = UITextField.BorderStyle.roundedRect
        dateTextField.autocorrectionType = UITextAutocorrectionType.no
        dateTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        dateTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        return dateTextField
    }
    
    static func createHorizontalStackView(arrangedSubviews: [UITextField]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.distribution = .equalSpacing
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }
    
}
