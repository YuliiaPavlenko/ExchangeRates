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
    
    static func createHorizontalStackView(arrangedSubviews: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.distribution = .equalSpacing
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }
    
    static func createMidTitleLabel() -> UILabel {
        let currencyLabel = UILabel()
        currencyLabel.textColor = Colors.grayTitle
        currencyLabel.font = Fonts.title
        currencyLabel.textAlignment = .left
        currencyLabel.numberOfLines = 0
        return currencyLabel
    }
    
    static func createMidValueLabel() -> UILabel {
        let midValueLabel = UILabel()
        midValueLabel.textColor = Colors.grayTitle
        midValueLabel.font = Fonts.title
        midValueLabel.textAlignment = .left
        midValueLabel.numberOfLines = 0
        return midValueLabel
    }
    
    static func createDateLabel() -> UILabel {
        let dateLabel = UILabel()
        dateLabel.textColor = .black
        dateLabel.font = Fonts.titleBold
        dateLabel.textAlignment = .left
        return dateLabel
    }
}
