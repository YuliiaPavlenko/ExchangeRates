//
//  Segment.swift
//  ExchangeRatesTestTask
//
//  Created by Yuliia Pavlenko on 18/04/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import UIKit

class Segment {
    
    var backgroundColor = UIColor.white
    var title: String!
    
    init(title: String) {
        self.title = title
    }
    
    init(title: String, backgroundColor: UIColor) {
        self.title = title
        self.backgroundColor = backgroundColor
    }
}
