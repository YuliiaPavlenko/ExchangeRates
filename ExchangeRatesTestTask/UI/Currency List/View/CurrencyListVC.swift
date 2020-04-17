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
    let spinner = UIActivityIndicatorView(style: .whiteLarge)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Currency rates"
        currencyListPresenter.viewDelegate = self
        setupTableView()
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(spinner)
        spinner.tintColor = .red
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        currencyListPresenter.viewIsPrepared()
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
    
    func setupSegmentedControl() {
        segmentedControl.addTarget(self, action: #selector(handleSegmentChange), for: .valueChanged)
    }
    
    @objc fileprivate func handleSegmentChange() {
        
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
        return 70
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currencyListPresenter.currencyClicked(indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

// MARK: CurrencyListViewDelegate
extension CurrencyListVC: CurrencyListViewDelegate {
    func showCurrencyData(_ data: [CurrencyListModel]) {
        currencyList = data
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func showDownloadCurrencyListDataError(withMessage: DisplayErrorModel) {
        DispatchQueue.main.async {
        let alert = CustomErrorAlert.setUpErrorAlert(withMessage)
            self.present(alert, animated: true)
        }
    }
    
    func showCurrencyDetails() {
        let currencyDetailsVC = CurrencyDetailsVC()
        navigationController?.pushViewController(currencyDetailsVC, animated: false)
    }

    func showProgress() {
        spinner.startAnimating()
    }

    func hideProgress() {
        DispatchQueue.main.async {
            self.tableView.refreshControl?.endRefreshing()
            self.spinner.stopAnimating()
        }
    }
}
