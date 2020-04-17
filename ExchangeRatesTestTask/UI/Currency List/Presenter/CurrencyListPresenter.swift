//
//  CurrencyListPresenter.swift
//  ExchangeRatesTestTask
//
//  Created by Yuliia Pavlenko on 16/04/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import UIKit

protocol CurrencyListViewDelegate: class {
    func showCurrencyData(_ data: [CurrencyListModel])
    func showDownloadCurrencyListDataError(withMessage: DisplayErrorModel)
    func showCurrencyDetails()
    func showProgress()
    func hideProgress()
}

class CurrencyListPresenter {
    var currencyList = [CurrencyListModel]()
    var originalCurrencyList = [Rate]()
    
    weak var viewDelegate: CurrencyListViewDelegate?
    
    func currencyClicked(_ atIndex: Int) {
        Cache.shared.setSelectedCurrencyRate(originalCurrencyList[atIndex])
        viewDelegate?.showCurrencyDetails()
    }

    func viewIsPrepared() {
        viewDelegate?.showProgress()
        
        NetworkManager.shared.getCurrenciesForTable(tableName: "B") { [weak self] (currency, error) in
            guard let self = self else { return }

            self.viewDelegate?.hideProgress()

            if let currency = currency {
                self.originalCurrencyList = currency.rates

                for rate in currency.rates {
                    let currency = CurrencyListModel(date: currency.effectiveDate, currency: rate.currency, code: rate.code, midValue: String(rate.mid!))
                    self.currencyList.append(currency)
                }

                self.viewDelegate?.showCurrencyData(self.currencyList)
            } else {
                if let error = error {
                    self.viewDelegate?.showDownloadCurrencyListDataError(withMessage: DisplayError.currencyList.displayMessage(erError: error))
                }
            }
        }

    }
}
