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
    var amountValue:Double = 1.00
    
    var timer:Timer?
    
    var fetchCallback:(()->())?
    
    init() {
        
        timer = Timer.scheduledTimer(timeInterval: 1800,
                                        target: self,
                                        selector: #selector(fetch),
                                        userInfo: nil,
                                        repeats: true)
    }
    
    @objc
    func fetch() {
        if let cb = fetchCallback {
            cb()
        }
    }
    
    func getAllCurrentConvertion(completion:@escaping((Bool) -> Void)) {
        
        APIService<CurrenciesAPIModel>.get(from: .currencies, completion: { result in
            switch result {
            case .success(let data):
                self.populateAvailableCurrencies(quotes: data.quotes)
                self.quotes = data.quotes
                self.persistData()
                completion(true)
            case .failure(let error):
                print(error)
                if self.getPersistedData() {
                    completion(true)
                    return
                }
                completion(false)
            }
            return
        })
    }
    
    func getCurrencyUnit(unit:String) -> String {
        let str = unit.replacingOccurrences(of: "USD",
                                            with: "",
                                            options: NSString.CompareOptions.literal, range: nil)
        
        if str == "" { return "USD" }
        
        return str
    }
    
    
    func computeToUSD(value:Double) -> Double {
        return (1 / value)
    }
    
    func getConvertedValue(key:String) -> String {
        guard let value = quotes[key] else {
            return "0.00"
        }
        
        let unitFrom = computeToUSD(value: value)
        let unitTo = computeToUSD(value: quotes[selectedUnit] ?? 0.00)
        
        let computedValue = (unitTo / unitFrom) * amountValue
        
        return String(format: "%.2f", computedValue)
    }
    
    private func populateAvailableCurrencies(quotes:[String:Double]) {
        currenciesList = quotes.keys.map({ $0 })
    }
    
    private func persistData() {
        UserDefaults.standard.set(quotes, forKey: "quotes")
    }
    
    private func getPersistedData() -> Bool {
        if let data = UserDefaults.standard.value(forKey: "quotes") {
            let dict = data as! [String:Double]
            quotes = dict
            return true
        }
        
        return false
    }
}
