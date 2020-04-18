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
        
        configureDatePicker()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDateTextFields()
        configureMidValueLabel()
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
    
    func configureDatePicker() {
        startDateTextField.inputView = startDatePicker
        endDateTextField.inputView = endDatePicker
        startDatePicker.datePickerMode = .date
        endDatePicker.datePickerMode = .date
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.setItems([flexSpace, doneButton], animated: true)
        startDateTextField.inputAccessoryView = toolBar
        endDateTextField.inputAccessoryView = toolBar
        
        startDatePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        endDatePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)

    }
    
    @objc func doneAction() {
        view.endEditing(true)
    }
    
    @objc func dateChanged() {
        getDateFromPicker()
    }
    
    func getDateFromPicker() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        startDateTextField.text = formatter.string(from: startDatePicker.date)
        endDateTextField.text = formatter.string(from: endDatePicker.date)

    }

}
