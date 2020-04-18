//
//  CurrencyListVC.swift
//  ExchangeRatesTestTask
//
//  Created by Yuliia Pavlenko on 16/04/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import UIKit

class CurrencyListVC: UIViewController {

    var refreshControl = UIRefreshControl()
    let tableView = UITableView(frame: .zero, style: .plain)
    
    var currencyList = [CurrencyListModel]()
    var currencyListPresenter = CurrencyListPresenter()
    
    // MARK: - View Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        customizeNavigationBar(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencyListPresenter.viewDelegate = self
        setupTableView()
    
        currencyListPresenter.viewIsPrepared()
    }
    
    // MARK: - Custom Functions
    func customizeNavigationBar(_ animated: Bool) {
        title = "Currency rates".capitalized
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: Colors.grayTitle, .font: Fonts.navigationTitle]
    }
    
    func configureView() {
        view.backgroundColor = .white
        
        let codeSegmented = CustomSegmentedControl(frame: CGRect(x: 0, y: 50, width: self.view.frame.width, height: 50), buttonTitle: ["A","B","C"])
        codeSegmented.delegate = self
        codeSegmented.backgroundColor = .clear
        view.addSubview(codeSegmented)
        
        codeSegmented.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leftAnchor, bottom: nil, trailing: view.rightAnchor, paddingTop: 10, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 30, enableInsets: false)
        
        tableView.anchor(top: codeSegmented.bottomAnchor, leading: view.leftAnchor, bottom: view.bottomAnchor, trailing: view.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
    }

    func setupTableView() {
        view.addSubview(tableView)
        configureView()

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
//
//    func showProgress() {
//        
//    }

    func hideProgress() {
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
        }
    }
}

// MARK: CustomSegmentedControlDelegate
extension CurrencyListVC: CustomSegmentedControlDelegate {
    func changeToIndex(index: Int) {
        
    }
}
