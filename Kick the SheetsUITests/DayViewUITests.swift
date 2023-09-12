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

        let addTodoTextField = app.textFields["addTodoTextField"]
        addTodoTextField.fill(with: "Test")
        XCTAssertEqual(addTodoTextField.value as? String, "Test")

        app.buttons["Submit"].tap()

        XCTAssertTrue(isOn(.todoView))
        XCTAssertTrue(app.staticTexts["Test"].exists)
    }
}
