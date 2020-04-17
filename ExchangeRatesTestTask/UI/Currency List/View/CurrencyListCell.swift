//
//  CurrencyListCell.swift
//  ExchangeRatesTestTask
//
//  Created by Yuliia Pavlenko on 17/04/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import UIKit

class CurrencyListCell: UITableViewCell {
    static let Identifier = "CurrencyListCell"

    let dateLabel = CurrencyListViewElements.createDateLabel()
    let currencyLabel = CurrencyListViewElements.createCurrencyLabel()
    let codeLabel = CurrencyListViewElements.createCodeLabel()
    let midValueLabel = CurrencyListViewElements.createMidValueLabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(dateLabel)
        
        dateLabel.anchor(top: topAnchor, leading: leftAnchor, bottom: nil, trailing: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 20, enableInsets: false)
        
        let currencyDataStackView = CurrencyListViewElements.createHorizontalStackView(arrangedSubviews: [currencyLabel, codeLabel, midValueLabel])
        addSubview(currencyDataStackView)
        currencyDataStackView.anchor(top: dateLabel.bottomAnchor, leading: leftAnchor, bottom: bottomAnchor, trailing: rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 10, width: 0, height: 0, enableInsets: false)

    }
    
    func configureWithCurrency(_ currency: CurrencyListModel) {
        dateLabel.text = currency.date ?? "Empty date"
        currencyLabel.text = currency.currency ?? "Empty currency"
        codeLabel.text = currency.code ?? "+00 000 000 000"
        midValueLabel.text = currency.midValue ?? "No mid value"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
