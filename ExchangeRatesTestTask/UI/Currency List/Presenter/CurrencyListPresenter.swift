//
//  CurrencyListPresenter.swift
//  ExchangeRatesTestTask
//
//  Created by Yuliia Pavlenko on 16/04/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import UIKit

protocol CurrencyListViewDelegate: class {
//    func showCurrencyDetails()
    func showCurrencyData(_ data: [CurrencyListModel])
}

class CurrencyListPresenter {
    var currencyList = [CurrencyListModel]()

    weak var viewDelegate: CurrencyListViewDelegate?

    func viewIsPrepared() {
        NetworkManager.shared.getCurrenciesForTable(tableName: "A") { [weak self] (currency, error) in
            guard let self = self else { return }

//            self.viewDelegate?.hideProgress()

            if let currency = currency {
//                self.originalUsers = users

                for rate in currency.rates {
                    let currency = CurrencyListModel(date: currency.effectiveDate, currency: rate.currency, code: rate.code, midValue: String(rate.mid))
                    self.currencyList.append(currency)
//                    Cache.shared.setUserImage(self.getRandomImage())
                }

                self.viewDelegate?.showCurrencyData(self.currencyList)
            } else {
                if let error = error {
//                    self.viewDelegate?.showDownloadUsersDataError(withMessage: DisplayError.usersList.displayMessage(rtError: error))
                }
            }
        }

    }
}
