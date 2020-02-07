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
    
    func getAllCurrentConvertion(completion:@escaping((Bool) -> Void)) {
        APIService<CurrenciesAPIModel>.get(from: .currencies, completion: { result in
            switch result {
            case .success(let data):
                self.populateavailableCurrencies(quotes: data.quotes)
                completion(true)
            case .failure(let error):
                print(error)
                completion(false)
            }
        })
    }
    
    private func populateavailableCurrencies(quotes:[String:Double]) {
        currenciesList = quotes.keys.map({ $0 })
    }
}
