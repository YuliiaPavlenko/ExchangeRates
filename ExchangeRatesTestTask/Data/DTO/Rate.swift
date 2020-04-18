//
//  Rate.swift
//  ExchangeRatesTestTask
//
//  Created by Yuliia Pavlenko on 17/04/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import Foundation

struct Rate: Codable {
    let currency, code, no, effectiveDate: String?
    let mid, bid, ask: Double?
}
