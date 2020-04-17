//
//  CurrencyListViewElements.swift
//  ExchangeRatesTestTask
//
//  Created by Yuliia Pavlenko on 17/04/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import UIKit

class CurrencyListViewElements {

    static func createDateLabel() -> UILabel {
        let dateLabel = UILabel()
        dateLabel.textColor = .black
//        dateLabel.font = Fonts.title
        dateLabel.textAlignment = .left
        return dateLabel
    }

    static func createCurrencyLabel() -> UILabel {
        let currencyLabel = UILabel()
//        currencyLabel.textColor = Colors.graySubtitle
//        currencyLabel.font = Fonts.subtitle
        currencyLabel.textAlignment = .left
        currencyLabel.numberOfLines = 0
        return currencyLabel
    }
    
    static func createCodeLabel() -> UILabel {
        let codeLabel = UILabel()
//        codeLabel.textColor = Colors.graySubtitle
//        codeLabel.font = Fonts.subtitle
        codeLabel.textAlignment = .left
        codeLabel.numberOfLines = 0
        return codeLabel
    }
    
    static func createMidValueLabel() -> UILabel {
        let midValueLabel = UILabel()
//        midValueLabel.textColor = Colors.graySubtitle
//        midValueLabel.font = Fonts.subtitle
        midValueLabel.textAlignment = .left
        midValueLabel.numberOfLines = 0
        return midValueLabel
    }
    
    static func createHorizontalStackView(arrangedSubviews: [UILabel]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.distribution = .equalSpacing
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }
    
    static func createSegmentedControl(withItems: [String]) -> UISegmentedControl {
        let control = UISegmentedControl(items: withItems)
        control.selectedSegmentIndex = 0
        control.tintColor = .blue
        return control
    }
    
}
