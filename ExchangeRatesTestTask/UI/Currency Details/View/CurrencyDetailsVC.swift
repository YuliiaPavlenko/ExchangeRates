//
//  CurrencyDetailsVC.swift
//  ExchangeRatesTestTask
//
//  Created by Yuliia Pavlenko on 17/04/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import UIKit

class CurrencyDetailsVC: UIViewController {
    
    let midTitleLabel = CurrencyDetailsViewElements.createMidTitleLabel()
    let midValueLabel = CurrencyDetailsViewElements.createMidValueLabel()
    let startDateTextField = CurrencyDetailsViewElements.createDateTextField()
    let endDateTextField = CurrencyDetailsViewElements.createDateTextField()
    let startDatePicker = UIDatePicker()
    let endDatePicker = UIDatePicker()

    var currencyDetailsPresenter = CurrencyDetailsPresenter()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = .white
        customizeNavigationBar(true)
//        currencyDetailsPresenter.viewIsPrepared()
        configureStartDatePicker()
        configureEndDatePicker()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDateTextFields()
        configureMidValueLabel()
        currencyDetailsPresenter.viewDelegate = self
    }
    
    func customizeNavigationBar(_ animated: Bool) {
        title = currencyDetailsPresenter.selectedCurrencyRate?.currency?.capitalized
    }
    
    func configureMidValueLabel() {
        
        let midValueStackView = CurrencyDetailsViewElements.createHorizontalStackView(arrangedSubviews: [midTitleLabel, midValueLabel])
        view.addSubview(midValueStackView)
        
        midValueStackView.anchor(top: startDateTextField.bottomAnchor, leading: view.leftAnchor, bottom: nil, trailing: view.rightAnchor, paddingTop: 10, paddingLeft: 25, paddingBottom: 0, paddingRight: 25, width: 0, height: 0, enableInsets: false)
        
        midTitleLabel.text = "Mid Value"
        midValueLabel.text = currencyDetailsPresenter.setMidValue()
    }

    func configureDateTextFields() {
        startDateTextField.placeholder = "Enter start date"
        endDateTextField.placeholder = "Enter end date"
        
        let datesStackView = CurrencyDetailsViewElements.createHorizontalStackView(arrangedSubviews: [startDateTextField, endDateTextField])
        view.addSubview(datesStackView)
        
        datesStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leftAnchor, bottom: nil, trailing: view.rightAnchor, paddingTop: 10, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 0, enableInsets: false)
    }
    
    func configureToolBar(doneButtonAction: Selector?) -> UIToolbar {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: doneButtonAction)
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.setItems([flexSpace, doneButton], animated: true)
        return toolBar
    }
    
    func configureStartDatePicker() {
        startDateTextField.inputView = startDatePicker
        startDatePicker.datePickerMode = .date
        startDateTextField.inputAccessoryView = configureToolBar(doneButtonAction: #selector(startDateChanged))
    }
    
    func configureEndDatePicker() {
        endDateTextField.inputView = endDatePicker
        endDatePicker.datePickerMode = .date
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

// MARK: CurrencyDetailsViewDelegate
extension CurrencyDetailsVC: CurrencyDetailsViewDelegate {
    func showCurrencyDetails(_ data: CurrencyDetailsModel) {
        
    }
    
    func showCurrencyDetailsError() {
        
    }
    
    func setStartDate(_ date: String) {
        startDateTextField.text = date
    }
    
    func setEndDate(_ date: String) {
        endDateTextField.text = date
    }
    
    func showProgress() {
        
    }
    
    func hideProgress() {
        
    }
}
