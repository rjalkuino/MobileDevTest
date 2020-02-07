//
//  DashViewController.swift
//  MobileDevPayPayTest
//
//  Created by QuantumCrowd on 2/7/20.
//  Copyright © 2020 Robert John Alkuino. All rights reserved.
//

import UIKit

class DashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        APIService<CurrenciesAPIModel>.get(from: .currencies, completion: { result in
            switch result {
            case .success(let data):
                print(data)
            case .failure(let error):
                print(error)
            }
        })
    }

}
