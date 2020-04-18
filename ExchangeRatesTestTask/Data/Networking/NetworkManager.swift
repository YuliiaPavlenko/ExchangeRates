//
//  NetworkManager.swift
//  ExchangeRatesTestTask
//
//  Created by Yuliia Pavlenko on 17/04/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import Foundation

class NetworkManager {

    static let shared = NetworkManager()
    let session: URLSession

    private init() {
        session = URLSession(configuration: .default)
    }

    // MARK: - Generic methods
    private func getArrayOfData<Data: Decodable>(url: URL, completion: @escaping ((Data?, ERError?) -> Void)) {
        let task = session.dataTask(with: url, completionHandler: { data, response, error in

            if let error = validateApiResponse(response: response, error: error) {
                completion(nil, error)
                return
            }

            do {
                let json = try JSONDecoder().decode([Data].self, from: data!)

                completion(json[0], nil)
            } catch {
                completion(nil, ERError.parsingResponseError(errorInfo: self.parseJsonError(error: error)))
            }

        })
        task.resume()
    }
    
    private func getObject<Data: Decodable>(url: URL, completion: @escaping ((Data?, ERError?) -> Void)) {
        let task = session.dataTask(with: url, completionHandler: { data, response, error in

            if let error = validateApiResponse(response: response, error: error) {
                completion(nil, error)
                return
            }

            do {
                let json = try JSONDecoder().decode(Data.self, from: data!)

                completion(json, nil)
            } catch {
                completion(nil, ERError.parsingResponseError(errorInfo: self.parseJsonError(error: error)))
            }

        })
        task.resume()
    }
    
    // MARK: - Get data from server
    func getCurrenciesForTable(tableName: String, completion: @escaping ((Currency?, ERError?) -> Void)) {
        let url = URL(string: Router.getExchangeRatesForTable(tableName))!
        getArrayOfData(url: url, completion: completion)
    }

    func getRatesForDates(tableName: String, selectedCurrency: String, startDate: String, endDate: String, completion: @escaping ((Currency?, ERError?) -> Void)) {
        let url = URL(string: Router.getExchangeRatesForDates(startDate: startDate, endDate: endDate, tableName: tableName, selectedCurrency: selectedCurrency))!
        getObject(url: url, completion: completion)
    }
    
    func parseJsonError(error: Error) -> ErrorInfo {
        var errorInfo = ErrorInfo()
        errorInfo.message = "Error during JSON serialization: \(error.localizedDescription)"
        return errorInfo
    }
}
