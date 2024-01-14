//
//  Kick_the_SheetsUITests.swift
//  Kick the SheetsUITests
//
//  Created by Ayren King on 1/26/23.
//

import XCTest

final class AppLaunchUITests: XCTestCase {
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
