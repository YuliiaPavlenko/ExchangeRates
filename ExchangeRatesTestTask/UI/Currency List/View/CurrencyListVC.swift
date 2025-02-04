//
//  CurrencyListVC.swift
//  ExchangeRatesTestTask
//
//  Created by Yuliia Pavlenko on 16/04/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import UIKit
import PKHUD

class CurrencyListVC: UIViewController {

    var refreshControl = UIRefreshControl()
    let tableView = UITableView(frame: .zero, style: .plain)
    
    var currencyList = [CurrencyListModel]()
    var currencyListPresenter = CurrencyListPresenter()
    
    let tablesForCurrencies = ["A","B","C"]
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencyListPresenter.viewDelegate = self
        
        configureView()
        setupTableView()
    
        currencyListPresenter.viewIsPrepared()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        customizeNavigationBar(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
    }
    
    // MARK: - Custom Functions
    func customizeNavigationBar(_ animated: Bool) {
        title = "Currency rates".capitalized
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: Colors.grayTitle, .font: Fonts.navigationTitle]
    }
    
    func configureView() {
        view.backgroundColor = .white
        
        let customSegments = tablesForCurrencies.map() { Segment(title: $0, backgroundColor: Colors.lightGrayBackground) }
        
        let codeSegmented = CustomSegmentedControl(frame: CGRect(x: 0, y: 50, width: self.view.frame.width, height: 50), segments: customSegments)
        codeSegmented.delegate = self
        
        view.addSubview(codeSegmented)
        
        codeSegmented.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leftAnchor, bottom: nil, trailing: view.rightAnchor, paddingTop: 10, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 30, enableInsets: false)
        
        view.addSubview(tableView)
        
        tableView.anchor(top: codeSegmented.bottomAnchor, leading: view.leftAnchor, bottom: view.bottomAnchor, trailing: view.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.register(CurrencyListCell.self, forCellReuseIdentifier: CurrencyListCell.Identifier)
        
        configureRefreshControl()
    }
    
    func configureRefreshControl() {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        
        tableView.addSubview(refreshControl)
    }
    
    @objc func refresh() {
        currencyListPresenter.onRefreshSwiped()
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
        HUD.show(.progress)
    }

    func hideProgress() {
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
            HUD.hide()
        }
    }
}

// MARK: CustomSegmentedControlDelegate
extension CurrencyListVC: CustomSegmentedControlDelegate {
    func changeToIndex(index: Int) {
        let selectedTable = tablesForCurrencies[index]
        currencyListPresenter.tableSelected(selectedTable)
    }
}
