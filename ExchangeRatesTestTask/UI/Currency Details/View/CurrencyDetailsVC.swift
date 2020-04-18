//
//  CurrencyDetailsVC.swift
//  ExchangeRatesTestTask
//
//  Created by Yuliia Pavlenko on 17/04/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import UIKit
import PKHUD

class CurrencyDetailsVC: UIViewController {
    
    let startDateTextField = CurrencyDetailsViewElements.createDateTextField()
    let endDateTextField = CurrencyDetailsViewElements.createDateTextField()
    let startDatePicker = UIDatePicker()
    let endDatePicker = UIDatePicker()
    let tableView = UITableView(frame: .zero, style: .plain)
    var refreshControl = UIRefreshControl()

    var currencyDetailsList = [CurrencyDetailsModel]()
    var currencyDetailsPresenter = CurrencyDetailsPresenter()
    
    // MARK: - View Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = .white
        customizeNavigationBar(true)
        currencyDetailsPresenter.viewIsPrepared()
        configureStartDatePicker()
        configureEndDatePicker()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDateTextFields()
        currencyDetailsPresenter.viewDelegate = self
        setupTableView()
        configureRefreshControl()
    }
    
    // MARK: - Custom Functions
    func customizeNavigationBar(_ animated: Bool) {
        title = currencyDetailsPresenter.selectedCurrencyRate?.currency?.capitalized
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.register(CurrencyDetailsCell.self, forCellReuseIdentifier: CurrencyDetailsCell.Identifier)
        
    }
    
    func configureRefreshControl() {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc func refresh() {
        currencyDetailsPresenter.onRefreshSwiped()
    }

    func configureDateTextFields() {
        startDateTextField.placeholder = "Enter start date"
        endDateTextField.placeholder = "Enter end date"
        
        let datesStackView = CurrencyDetailsViewElements.createHorizontalStackView(arrangedSubviews: [startDateTextField, endDateTextField])
        view.addSubview(datesStackView)
        view.addSubview(tableView)
        
        datesStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leftAnchor, bottom: nil, trailing: view.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 0, enableInsets: false)
        
        tableView.anchor(top: datesStackView.bottomAnchor, leading: view.leftAnchor, bottom: view.bottomAnchor, trailing: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
    }
    
    func configureToolBar(doneButtonAction: Selector?) -> UIToolbar {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40))
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: doneButtonAction)
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.setItems([flexSpace, doneButton], animated: true)
        return toolBar
    }
    
    func configureStartDatePicker() {
        startDateTextField.inputView = startDatePicker
        startDatePicker.datePickerMode = .date
        startDatePicker.maximumDate = currencyDetailsPresenter.setMaximumDate()
        startDateTextField.inputAccessoryView = configureToolBar(doneButtonAction: #selector(startDateChanged))
    }
    
    func configureEndDatePicker() {
        endDateTextField.inputView = endDatePicker
        endDatePicker.datePickerMode = .date
        endDatePicker.maximumDate = currencyDetailsPresenter.setMaximumDate()
        endDateTextField.inputAccessoryView = configureToolBar(doneButtonAction: #selector(endDateChanged))
    }
    
    @objc func startDateChanged() {
        view.endEditing(true)
        currencyDetailsPresenter.startDateSelected(startDatePicker.date)
    }
    
    @objc func endDateChanged() {
        view.endEditing(true)
        currencyDetailsPresenter.endDateSelected(endDatePicker.date)
    }
}

// MARK: - UITableView Delegate & DataSource
extension CurrencyDetailsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencyDetailsList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyDetailsCell.Identifier, for: indexPath) as! CurrencyDetailsCell
        let currentItem = currencyDetailsList[indexPath.row]
        cell.configureWithCurrency(currentItem)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

// MARK: CurrencyDetailsViewDelegate
extension CurrencyDetailsVC: CurrencyDetailsViewDelegate {
    func showCurrencyDetails(_ data: [CurrencyDetailsModel]) {
        currencyDetailsList = data
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func showCurrencyDetailsError() {
        DispatchQueue.main.async {
            let alert = CustomErrorAlert.setUpErrorAlert(nil)
            self.present(alert, animated: true)
        }
    }

    func showDownloadCurrencyDetailsError(withMessage: DisplayErrorModel) {
        DispatchQueue.main.async {
            let alert = CustomErrorAlert.setUpErrorAlert(withMessage)
            self.present(alert, animated: true)
        }
    }
    
    
    func setStartDate(_ date: String) {
        startDateTextField.text = date
    }
    
    func setEndDate(_ date: String) {
        endDateTextField.text = date
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
    
    func selectInvalidDate() {
        let alert = CustomErrorAlert.errorDatesAlert()
        present(alert, animated: true)
    }
}
