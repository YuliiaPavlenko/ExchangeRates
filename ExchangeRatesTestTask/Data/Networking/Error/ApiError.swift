//
//  ApiError.swift
//  ExchangeRatesTestTask
//
//  Created by Yuliia Pavlenko on 17/04/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import Foundation

enum ERError: Error {
    case serverError(errorInfo: ErrorInfo?)
    case unknown(errorInfo: ErrorInfo?)
    case communicationError(errorInfo: ErrorInfo?)
    case parsingResponseError(errorInfo: ErrorInfo?)

    static func get(errorInfo: ErrorInfo?) -> ERError {
        guard let code = errorInfo?.httpCode else {
            return unknown(errorInfo: errorInfo)
        }

        if [404, 406, 429, 500].contains(code) {
            return serverError(errorInfo: errorInfo)
        } else {
            return unknown(errorInfo: errorInfo)
        }
    }

    var debugDescription: String {
        return debugInfo ?? "No debug info"
    }

    private var debugInfo: String? {
        switch self {
        case .serverError(let errorInfo),
             .unknown(let errorInfo),
             .communicationError(let errorInfo),
             .parsingResponseError(let errorInfo):

            return "ErrorInfo: \(String(describing: errorInfo?.debugInfo))"
        }
    }
}
