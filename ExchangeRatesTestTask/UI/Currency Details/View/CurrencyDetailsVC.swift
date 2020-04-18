//
//  CurrencyDetailsVC.swift
//  ExchangeRatesTestTask
//
//  Created by Yuliia Pavlenko on 17/04/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import UIKit

class CurrencyDetailsVC: UIViewController {

    var currencyDetailsPresenter = CurrencyDetailsPresenter()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        customizeNavigationBar(true)
//        currencyDetailsPresenter.viewIsPrepared()
    }
    
    func customizeNavigationBar(_ animated: Bool) {
        title = currencyDetailsPresenter.selectedCurrencyRate?.currency?.capitalized
    }
}
