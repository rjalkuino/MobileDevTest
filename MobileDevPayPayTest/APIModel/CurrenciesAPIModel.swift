//
//  CurrenciesAPIModel.swift
//  MobileDevPayPayTest
//
//  Created by QuantumCrowd on 2/7/20.
//  Copyright © 2020 Robert John Alkuino. All rights reserved.
//

import UIKit

struct CurrenciesAPIModel: Codable {
    let quotes: [String:Any]
    let timestamp: Double
    let source: String
}
