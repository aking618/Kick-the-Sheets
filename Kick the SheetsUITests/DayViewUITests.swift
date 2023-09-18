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

    func testAddTodoError() throws {
        app.buttons["addTodoButton"].tap()
        XCTAssertTrue(isOn(.addTodoView))

        app.buttons["Submit"].tap()
        XCTAssertTrue(app.staticTexts["addTodoError"].waitForExistence)

        let addTodoTextField = app.textFields["addTodoTextField"]
        addTodoTextField.fill(with: "Test")

        app.buttons["Submit"].tap()
        XCTAssertTrue(isOn(.todoView))
    }

    func testAddTodoCancelWithText() throws {
        let addTodoButton = app.buttons["addTodoButton"]
        addTodoButton.tap()
        XCTAssertTrue(isOn(.addTodoView))

        let addTodoTextField = app.textFields["addTodoTextField"]
        addTodoTextField.fill(with: "Test")

        app.buttons["Cancel"].tap()
        XCTAssertTrue(isOn(.todoView))

        addTodoButton.tap()
        XCTAssertTrue(isOn(.addTodoView))

        XCTAssertEqual(addTodoTextField.value as? String, "")
    }
}
