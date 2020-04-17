//
//  Currency.swift
//  ExchangeRatesTestTask
//
//  Created by Yuliia Pavlenko on 17/04/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import Foundation

struct Currency: Codable {
    let table, no, effectiveDate: String
    let rates: [Rate]
}
