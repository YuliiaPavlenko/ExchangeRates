//
//  CurrencyListPresenter.swift
//  ExchangeRatesTestTask
//
//  Created by Yuliia Pavlenko on 16/04/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import UIKit

protocol CurrencyListViewDelegate: class {
    func showCurrencyDetails()
    func showCurrencyData(_ data: [CurrencyListModel])
}

class CurrencyListPresenter {
    var currencyList = [CurrencyListModel]()

    weak var viewDelegate: CurrencyListViewDelegate?

    func viewIsPrepared() {

    }
}
