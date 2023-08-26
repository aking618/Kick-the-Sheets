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
    var todoService: TodoService!

    override func setUpWithError() throws {
        todoService = GeneralTodoService(directory: "TaskDemoDB", store: "taskDemo.sqlite3")
        appState = AppState(todoService: todoService)
    }

    override func tearDownWithError() throws {
        appState = nil
        todoService = nil
    }
}
