//
//  Router.swift
//  ExchangeRatesTestTask
//
//  Created by Yuliia Pavlenko on 17/04/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import Foundation

class Router {
    
    static func getExchangeRatesForTable(_ tableName: String) -> String {
        return Config.baseURL + "tables/\(tableName)/"
    }
    
    static func getExchangeRatesForDates(startDate: String, endDate: String, tableName: String, selectedCurrency: String) -> String {
        return Config.baseURL + "rates/\(tableName)/" + "\(selectedCurrency)/" + "\(startDate)/" + "\(endDate)/"
    }
}
