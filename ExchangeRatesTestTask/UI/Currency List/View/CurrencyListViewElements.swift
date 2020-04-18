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
        dateLabel.font = Fonts.titleBold
        dateLabel.textAlignment = .left
        return dateLabel
    }

    static func createCurrencyLabel() -> UILabel {
        let currencyLabel = UILabel()
        currencyLabel.textColor = Colors.grayTitle
        currencyLabel.font = Fonts.titleRegular
        currencyLabel.textAlignment = .left
        currencyLabel.numberOfLines = 0
        return currencyLabel
    }
    
    static func createCodeLabel() -> UILabel {
        let codeLabel = UILabel()
        codeLabel.textColor = Colors.grayTitle
        codeLabel.font = Fonts.titleRegular
        codeLabel.textAlignment = .left
        codeLabel.numberOfLines = 0
        return codeLabel
    }
    
    static func createMidValueLabel() -> UILabel {
        let midValueLabel = UILabel()
        midValueLabel.textColor = Colors.grayTitle
        midValueLabel.font = Fonts.titleRegular
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
}
