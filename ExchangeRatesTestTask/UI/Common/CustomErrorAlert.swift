//
//  CustomErrorAlert.swift
//  ExchangeRatesTestTask
//
//  Created by Yuliia Pavlenko on 17/04/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import UIKit

class CustomErrorAlert {

    static func setUpErrorAlert(_ withMessage: DisplayErrorModel?) -> UIAlertController {
        let errorTitle = withMessage?.title
        let alert = UIAlertController(title: errorTitle, message: withMessage?.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_: UIAlertAction!) in
        }))
        return alert
    }
    
    static func errorDatesAlert() -> UIAlertController {
        let errorTitle = "Selection data error"
        let errorMessage = "Please, make sure that start date is less that end date"
        let alert = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_: UIAlertAction!) in
        }))
        return alert
    }
}
