//
//  CurrencyListVC.swift
//  ExchangeRatesTestTask
//
//  Created by Yuliia Pavlenko on 16/04/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import UIKit

class CurrencyListVC: UIViewController {
    
    var currencyList = [CurrencyListModel]()
    var currencyListPresenter = CurrencyListPresenter()
    
    lazy var segmentedControl = CurrencyListViewElements.createSegmentedControl(withItems: ["Table A", "Table B", "Table C"])
    let tableView = UITableView(frame: .zero, style: .plain)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Currency rates"
        currencyListPresenter.viewDelegate = self
        setupTableView()
        currencyListPresenter.viewIsPrepared()
        
        
//        let currency1 = CurrencyListModel(date: "12345", currency: "Dolar Amerykański", code: "USD", midValue: "123")
//        let currency2 = CurrencyListModel(date: "12345", currency: "Dolar Amerykański", code: "USD", midValue: "123")
//        let currency3 = CurrencyListModel(date: "12345", currency: "Dolar Amerykański", code: "USD", midValue: "123")
//        let currency4 = CurrencyListModel(date: "12345", currency: "Dolar Amerykański", code: "USD", midValue: "123")
//        let currency5 = CurrencyListModel(date: "12345", currency: "Dolar Amerykański", code: "USD", midValue: "123")
//        self.currencyList.append(currency1)
//        self.currencyList.append(currency2)
//        self.currencyList.append(currency3)
//        self.currencyList.append(currency4)
//        self.currencyList.append(currency5)

    }

    func setupTableView() {
        view.addSubview(tableView)
        configureStackView()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.register(CurrencyListCell.self, forCellReuseIdentifier: CurrencyListCell.Identifier)
    }

    fileprivate func configureStackView() {
        let stackView = UIStackView(arrangedSubviews: [segmentedControl, tableView])
        stackView.axis = .vertical
        
        view.addSubview(stackView)

        stackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leftAnchor, bottom: view.bottomAnchor, trailing: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
    }
}

// MARK: - UITableView Delegate & DataSource
extension CurrencyListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencyList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyListCell.Identifier, for: indexPath) as! CurrencyListCell
        let currentItem = currencyList[indexPath.row]
        cell.configureWithCurrency(currentItem)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        profilePresenter.profileClicked(indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

// MARK: ProfileViewDelegate
extension CurrencyListVC: CurrencyListViewDelegate {
    func showCurrencyData(_ data: [CurrencyListModel]) {
        currencyList = data
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

}
