//
//  DisplayError.swift
//  ExchangeRatesTestTask
//
//  Created by Yuliia Pavlenko on 17/04/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import Foundation

struct DisplayErrorModel {
    var title: String
    var message: String
}

enum DisplayError {
    case currencyList, rates

    func displayMessage(erError: ERError) -> DisplayErrorModel {
        switch self {
        case .currencyList:
            return getErrorMessageForCurrencyLists(erError: erError)
        case .rates:
            return getErrorMessageGetRatesforDates(erError: erError)
        }
    }

    private func getErrorMessageForCurrencyLists(erError: ERError) -> DisplayErrorModel {
        let errorDescription = "Error get currencies list"
        var message: String?
        switch erError {
        case .serverError, .unknown, .communicationError:
            message = "Failed to currencies list. Please make sure you\'re connected to the internet and try again.\nContact support if the problem continues."
        default:
            message = "Unknown error"
        }
        #if DEBUG
        message = erError.debugDescription
        #endif
        return DisplayErrorModel(title: errorDescription, message: message!)
    }

    private func getErrorMessageGetRatesforDates(erError: ERError) -> DisplayErrorModel {
        let errorDescription = "Error get rates"
        var message: String?
        switch erError {
        case .serverError:
            message = "No data for selected period.\nPlease select another dates."
        case .unknown, .communicationError:
            message = "Failed to get rates for selected dates. Please make sure you\'re connected to the internet and try again.\nContact support if the problem continues."
        default:
            message = "Unknown error"
        }
        #if DEBUG
        message = erError.debugDescription
        #endif
        return DisplayErrorModel(title: errorDescription, message: message!)
    }
}
