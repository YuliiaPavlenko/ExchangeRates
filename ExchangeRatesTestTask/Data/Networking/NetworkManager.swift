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

    func getCurrenciesForTable(tableName: String, completion: @escaping ((Currency?, ERError?) -> Void)) {
        let url = URL(string: Router.getExchangeRatesForTable(tableName))!
        let task = session.dataTask(with: url, completionHandler: { data, response, error in

            if let error = validateApiResponse(response: response, error: error) {
                completion(nil, error)
                return
            }

            do {
                let json = try JSONDecoder().decode([Currency].self, from: data!)

                completion(json[0], nil)
            } catch {
                var errorInfo = ErrorInfo()
                errorInfo.message = "Error during JSON serialization: \(error.localizedDescription)"

                completion(nil, ERError.parsingResponseError(errorInfo: errorInfo))
            }

        })
        task.resume()
    }

//    func getPostsForUser(userId: Int, completion: @escaping (([Post]?, ERError?) -> Void)) {
//        let url = URL(string: Router.postsForUser(userId))!
//        let task = session.dataTask(with: url, completionHandler: { data, response, error in
//
//            if let error = validateApiResponse(response: response, error: error) {
//                completion(nil, error)
//                return
//            }
//
//            do {
//                let json = try JSONDecoder().decode([Post].self, from: data! )
//
//                completion(json, nil)
//
//            } catch {
//                print("Error during JSON serialization: \(error.localizedDescription)")
//                var errorInfo = ErrorInfo()
//                errorInfo.message = "Error during JSON serialization: \(error.localizedDescription)"
//
//                completion(nil, RTError.parsingResponseError(errorInfo: errorInfo))
//            }
//
//        })
//        task.resume()
//    }
}
