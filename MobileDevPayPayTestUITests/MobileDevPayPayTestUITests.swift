//
//  MobileDevPayPayTestUITests.swift
//  MobileDevPayPayTestUITests
//
//  Created by Robert John Alkuino on 2/8/20.
//  Copyright © 2020 Robert John Alkuino. All rights reserved.
//

import XCTest

class MobileDevPayPayTestUITests: XCTestCase {

    var app:XCUIApplication!
    
    override func setUp() {
        app = XCUIApplication()
        app.launch()
    }

    func testUI() {
        let amountField = app.textFields["1.00"]
        let convertBtn = app.buttons["CONVERT"]
        let currencySelectorBtn = app.buttons["USD"]
        
        XCTAssertTrue(amountField.exists)
        XCTAssertTrue(convertBtn.exists)
        XCTAssertTrue(currencySelectorBtn.exists)
    }
}
