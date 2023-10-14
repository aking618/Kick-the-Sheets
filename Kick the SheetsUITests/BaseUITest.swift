//
//  BaseUITest.swift
//  Kick the SheetsUITests
//
//  Created by Ayren King on 9/4/23.
//

import XCTest

class BaseUITest: XCTestCase {
    let app = XCUIApplication()

    override func setUp() {
        super.setUp()

        continueAfterFailure = false
        app.launchArguments = ["-ui_testing"]
        app.launch()
    }

    override func tearDown() {
        super.tearDown()

        app.terminate()
    }

    func isOn(_ view: NativeView) -> Bool {
        switch view {
        case .todoView, .homeView, .settingsView:
            return app.buttons[view.rawValue].value as? String == "Y"
        case .addTodoView:
            return app.descendants(matching: .any)[view.rawValue].firstMatch.exists
        }
    }

    func dismissKeyboardIfPresent() {
        guard app.keyboards.count > 0 else { return }

        guard UIDevice.current.userInterfaceIdiom == .phone else {
            app.keyboards.buttons["Hide keyboard"].tap()
            return
        }

        if app.toolbars.buttons["Done"].exists {
            app.toolbars.buttons["Done"].tap()
        } else {
            app.typeText("\n")
        }
    }
}

extension XCUIElement {
    var waitForExistence: Bool {
        waitForExistence(timeout: 5)
    }

    func fill(with text: String) {
        tap()
        typeText(text)
    }
}

enum NativeView: String {
    case todoView
    case homeView
    case settingsView
    case addTodoView
}
