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
//    func showProgress()
    func hideProgress()
}

class CurrencyListPresenter {
    var currencyList = [CurrencyListModel]()
    var originalCurrencyList = [Rate]()
    var selectedTable: String? = "A"
    
    weak var viewDelegate: CurrencyListViewDelegate?
    
    func currencyClicked(_ atIndex: Int) {
        Cache.shared.setSelectedCurrencyRate(originalCurrencyList[atIndex])
        Cache.shared.setSelectedCurrencyTable(selectedTable!)
        viewDelegate?.showCurrencyDetails()
    }
    
    func viewIsPrepared() {
//        viewDelegate?.showProgress()
        getCurrencyList()
    }
    
    func onRefreshSwiped() {
//        viewDelegate?.showProgress()
        getCurrencyList()
    }
    
    fileprivate func getCurrencyList() {
        NetworkManager.shared.getCurrenciesForTable(tableName: selectedTable!) { [weak self] (currency, error) in
            guard let self = self else { return }
            
            self.viewDelegate?.hideProgress()
            
            if let currency = currency {
                self.originalCurrencyList = currency.rates
                
                for rate in currency.rates {
                    let currency = CurrencyListModel(date: currency.effectiveDate, currency: rate.currency, code: rate.code, midValue: self.getMidValue(rate))
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
    
    func getMidValue(_ rate: Rate) -> String {
        let midValue: String
        if let mid = rate.mid {
            midValue = String(mid)
        } else if let ask = rate.ask,
                  let bid = rate.bid {
            midValue = String((ask + bid) / 2)
        } else {
            midValue = "No value"
        }
        return midValue
    }
}
