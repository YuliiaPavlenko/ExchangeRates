//
//  ResponseValidator.swift
//  ExchangeRatesTestTask
//
//  Created by Yuliia Pavlenko on 17/04/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import Foundation

func validateApiResponse(response: URLResponse?, error: Error?) -> ERError? {
    var errorInfo = ErrorInfo()

    if let error = error {
        errorInfo.message = error.localizedDescription
        return ERError.communicationError(errorInfo: errorInfo)
    }

    if let httpResponse = response as? HTTPURLResponse {
        if httpResponse.statusCode != 200 {
            errorInfo.httpCode = httpResponse.statusCode
            return ERError.get(errorInfo: errorInfo)
        }
    }

    return nil
}
