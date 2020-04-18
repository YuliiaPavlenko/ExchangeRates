//
//  CurrencyDetailsPresenter.swift
//  ExchangeRatesTestTask
//
//  Created by Yuliia Pavlenko on 17/04/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import Foundation

protocol CurrencyDetailsViewDelegate: class {
    func showCurrencyDetails(_ data: CurrencyDetailsModel)
    func showCurrencyDetailsError()
    func setStartDate(_ date: String)
    func setEndDate(_ date: String)
    func showProgress()
    func hideProgress()
}

class CurrencyDetailsPresenter {
    let selectedCurrencyRate = Cache.shared.getSelectedCurrencyRate()
    var currencyDetails = [CurrencyDetailsModel]()
    var startDate: String?
    var endDate: String?
    
    var formatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }
    weak var viewDelegate: CurrencyDetailsViewDelegate?
//
//    func viewIsPrepared() {
//        if let currencyRate = selectedCurrencyRate {
//            viewDelegate?.showProgress()
//
//            NetworkManager.shared.getRatesForDates(tableName: "C", startDate: "", endDate: "") { [weak self] (currency, error) in
//                guard let self = self else { return }
//
//                self.viewDelegate?.hideProgress()
//
//                if let currency = currency {
//
//                    for rate in currency.rates {
//                        let currency = CurrencyDetailsModel(startDate: startDate, endDate: endDate, currency: )
//                        self.currencyDetails.append(currency)
//                    }
//
//                } else {
//                    if let error = error {
//                        self.viewDelegate?.showDownloadCurrencyListDataError(withMessage: DisplayError.currencyList.displayMessage(erError: error))
//                    }
//                }
//            }
//        } else {
//            viewDelegate?.showCurrencyDetailsError()
//        }
//    }

    func setMidValue() -> String {
        return getMidValue(selectedCurrencyRate)
    }
    
    func getMidValue(_ rate: Rate?) -> String {
        let midValue: String
        if let mid = rate?.mid {
            midValue = String(mid)
        } else if let ask = rate?.ask,
            let bid = rate?.bid {
            midValue = String((ask + bid) / 2)
        } else {
            midValue = "No value"
        }
        return midValue
    }
    
    func startDateSelected(_ date: Date) {
        startDate = formatter.string(from: date)
        viewDelegate?.setStartDate(startDate!)
        // call backend
    }
    
    func endDateSelected(_ date: Date) {
        endDate = formatter.string(from: date)
        viewDelegate?.setEndDate(endDate!)
    }
    
}
