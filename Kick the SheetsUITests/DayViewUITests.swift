//
//  DayViewUITests.swift
//  Kick the SheetsUITests
//
//  Created by Ayren King on 9/3/23.
//

import XCTest

final class DayViewUITests: BaseUITest {
    func testShowAddTodoForm() throws {
        app.buttons["addTodoButton"].tap()
        XCTAssertTrue(isOn(.addTodoView))

        app.textFields["addTodoTextField"].fill(with: "Test")
        app.buttons["Submit"].tap()

        XCTAssertTrue(isOn(.todoView))
    }
}
