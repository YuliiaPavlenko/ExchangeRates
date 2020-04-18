//
//  CurrencyDetailsCell.swift
//  ExchangeRatesTestTask
//
//  Created by Yuliia Pavlenko on 18/04/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import UIKit

class CurrencyDetailsCell: UITableViewCell {
    static let Identifier = "CurrencyDetailsCell"

    let dateLabel = CurrencyDetailsViewElements.createDateLabel()
    let midValueLabel = CurrencyDetailsViewElements.createMidValueLabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(dateLabel)
        addSubview(midValueLabel)
        dateLabel.anchor(top: topAnchor, leading: leftAnchor, bottom: nil, trailing: nil, paddingTop: 12, paddingLeft: 20, paddingBottom: 0, paddingRight: 12, width: 0, height: 20, enableInsets: false)
        midValueLabel.anchor(top: dateLabel.bottomAnchor, leading: leftAnchor, bottom: bottomAnchor, trailing: nil, paddingTop: 6, paddingLeft: 20, paddingBottom: 12, paddingRight: 0, width: 0, height: 20, enableInsets: false)
    }
    
    func configureWithCurrency(_ currency: CurrencyDetailsModel) {
        dateLabel.text = currency.date ?? "Empty date"
        midValueLabel.text = currency.midValue
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
