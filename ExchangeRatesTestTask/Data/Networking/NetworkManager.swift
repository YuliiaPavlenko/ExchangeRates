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

    private func getData<Data: Decodable>(url: URL, completion: @escaping ((Data?, ERError?) -> Void)) {
        let task = session.dataTask(with: url, completionHandler: { data, response, error in

            if let error = validateApiResponse(response: response, error: error) {
                completion(nil, error)
                return
            }

            do {
                let json = try JSONDecoder().decode([Data].self, from: data!)

                completion(json[0], nil)
            } catch {
                var errorInfo = ErrorInfo()
                errorInfo.message = "Error during JSON serialization: \(error.localizedDescription)"

                completion(nil, ERError.parsingResponseError(errorInfo: errorInfo))
            }

        })
        task.resume()
    }

    func getCurrenciesForTable(tableName: String, completion: @escaping ((Currency?, ERError?) -> Void)) {
        let url = URL(string: Router.getExchangeRatesForTable(tableName))!
        getData(url: url, completion: completion)
    }

    func getRatesForDates(tableName: String, startDate: String, endDate: String, completion: @escaping ((Currency?, ERError?) -> Void)) {
        let url = URL(string: Router.getExchangeRatesForDates(startDate: startDate, endDate: endDate, tableName: tableName))!
        getData(url: url, completion: completion)
    }
}
