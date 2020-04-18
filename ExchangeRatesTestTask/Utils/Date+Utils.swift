//
//  Date+Utils.swift
//  ExchangeRatesTestTask
//
//  Created by Yuliia Pavlenko on 18/04/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import Foundation

extension Date {
    var dayBefore: Date {
        Calendar.current.date(byAdding: .day, value: -1, to: self)!
    }
}
