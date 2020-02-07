//
//  DashViewModel.swift
//  MobileDevPayPayTest
//
//  Created by QuantumCrowd on 2/7/20.
//  Copyright © 2020 Robert John Alkuino. All rights reserved.
//

import UIKit

class DashViewModel {
    
    var currenciesList:[String] = []
    var quotes:[String:Double] = [:]
    var selectedUnit:String = "USDUSD"
    
    func getAllCurrentConvertion(completion:@escaping((Bool) -> Void)) {
        APIService<CurrenciesAPIModel>.get(from: .currencies, completion: { result in
            switch result {
            case .success(let data):
                self.populateavailableCurrencies(quotes: data.quotes)
                self.quotes = data.quotes
                completion(true)
            case .failure(let error):
                print(error)
                completion(false)
            }
        })
    }
    
    func getCurrencyUnit(unit:String) -> String {
        let str = unit.replacingOccurrences(of: "USD",
                                            with: "",
                                            options: NSString.CompareOptions.literal, range: nil)
        
        if str == "" { return "USD" }
        
        return str
    }
    
    func getConvertedValue(key:String) -> String {
        guard let value = quotes[key] else {
            return "0.00"
        }
        
        return String(format: "%.2f", value)
    }
    
    private func populateavailableCurrencies(quotes:[String:Double]) {
        currenciesList = quotes.keys.map({ $0 })
    }
}
