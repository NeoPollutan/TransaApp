//
//  Extensions.swift
//  ExpenseTracker
//
//  Created by Rizky Adipratama Ruddyar on 28/04/20.
//  Copyright © 2020 Rizky Adipratama Ruddyar. All rights reserved.
//

import Foundation

extension Double {
    
    var formattedCurrencyText: String {
        return Utils.numberFormatter.string(from: NSNumber(value: self)) ?? "0"
    }
    
}
