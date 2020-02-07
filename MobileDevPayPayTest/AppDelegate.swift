//
//  AppDelegate.swift
//  MobileDevPayPayTest
//
//  Created by QuantumCrowd on 2/7/20.
//  Copyright © 2020 Robert John Alkuino. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let controller = DashViewController.loadFromNib()
        window?.rootViewController = UINavigationController(rootViewController: controller)
        window?.makeKeyAndVisible()
        
        
        return true
    }


}

