//
//  Cache.swift
//  ExchangeRatesTestTask
//
//  Created by Yuliia Pavlenko on 17/04/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import Foundation

class Cache {
    static let shared = Cache()

    private var selectedCurrencyRate: Rate?

    private init() {
    }

    func setSelectedCurrencyRate(_ rate: Rate) {
        selectedCurrencyRate = rate
    }

    func getSelectedCurrencyRate() -> Rate? {
        return selectedCurrencyRate
    }

}
