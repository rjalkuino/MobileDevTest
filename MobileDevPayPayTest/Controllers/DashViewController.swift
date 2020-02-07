//
//  DashViewController.swift
//  MobileDevPayPayTest
//
//  Created by QuantumCrowd on 2/7/20.
//  Copyright © 2020 Robert John Alkuino. All rights reserved.
//

import UIKit

class DashViewController: UIViewController {
    
    let viewModel = DashViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.getAllCurrentConvertion(completion: { [weak self ] isSuccess in
            guard let weakSelf = self else { return }
        })
        
    }

}
