//
//  AppStateTests.swift
//  Kick the SheetsTests
//
//  Created by Ayren King on 8/9/23.
//

import XCTest

@testable import Kick_the_Sheets

final class AppStateTests: XCTestCase {
    var appState: AppState!
    var todoService: MockTodoService!

    override func setUpWithError() throws {
        todoService = MockTodoService()
        appState = AppState(todoService: todoService)
    }

    override func tearDownWithError() throws {
        appState = nil
        todoService = nil
    }

    func testUpdateLastPopupDate() throws {
        let previousPopupDate = UserDefaults.standard.object(forKey: "lastPopupDate")
        UserDefaults.standard.removeObject(forKey: "lastPopupDate")
        XCTAssertNil(UserDefaults.standard.object(forKey: "lastPopupDate"))

        appState.updateLastPopupDate()

        XCTAssertNotNil(UserDefaults.standard.object(forKey: "lastPopupDate"))
        UserDefaults.standard.set(previousPopupDate, forKey: "lastPopupDate")
    }
}

class MockTodoService: GeneralTodoService {
    override var DIR_TASK_DB: String {
        get {
            return "TaskDemoDB"
        }
        set {}
    }

    override var STORE_NAME: String {
        get {
            return "taskDemo.sqlite3"
        }
        set {}
    }
}
