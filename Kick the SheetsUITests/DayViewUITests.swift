//
//  DayViewUITests.swift
//  Kick the SheetsUITests
//
//  Created by Ayren King on 9/3/23.
//

import XCTest

final class DayViewUITests: BaseUITest {
    func testShowAddTodoForm() throws {
        XCTAssertFalse(isOn(.addTodoView))

        app.buttons["addTodoButton"].tap()
        XCTAssertTrue(isOn(.addTodoView))

        app.textFields["addTodoTextField"].fill(with: "Test")
        XCTAssertEqual(app.textFields["addTodoTextField"].value as? String, "Test")

        app.buttons["Submit"].tap()

        XCTAssertTrue(isOn(.todoView))
        XCTAssertTrue(app.staticTexts["Test"].exists)
    }
}
