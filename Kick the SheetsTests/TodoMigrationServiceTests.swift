//
//  TodoMigrationServiceTests.swift
//  Kick the SheetsTests
//
//  Created by Ayren King on 8/22/23.
//

import XCTest

@testable import Kick_the_Sheets

final class TodoMigrationServiceTests: XCTestCase {
    var todoMigrationService: TodoMigrationService!
    let userDefaults = UserDefaults.standard

    override func setUp() {
        let todoService: TodoService = GeneralTodoService(directory: "TaskDemoDB", store: "taskDemo.sqlite3")

        todoMigrationService = TodoMigrationService(todoService: todoService)
    }

    override func tearDown() {
        todoMigrationService.todoService.deleteAllEntries()
        todoMigrationService = nil
    }

    func testShowMigrationPopup_FirstLaunch() throws {
        let previousLaunchDate = userDefaults.object(forKey: "lastLaunchDate") as? Date
        userDefaults.set(nil, forKey: "lastLaunchDate")

        XCTAssertFalse(todoMigrationService.shouldShowPopup())

        userDefaults.set(previousLaunchDate, forKey: "lastLaunchDate")
    }

    func testShowMigrationPopup_SameDay() throws {
        let previousLaunchDate = userDefaults.object(forKey: "lastLaunchDate") as? Date
        userDefaults.set(Date(), forKey: "lastLaunchDate")

        XCTAssertFalse(todoMigrationService.shouldShowPopup())

        userDefaults.set(previousLaunchDate, forKey: "lastLaunchDate")
    }

    func testShowMigrationPopup_NewDay_NoTodos() throws {
        let previousLaunchDate = userDefaults.object(forKey: "lastLaunchDate") as? Date
        let previousDay = try XCTUnwrap(Calendar.current.date(byAdding: .day, value: -1, to: Date()))
        userDefaults.set(previousDay, forKey: "lastLaunchDate")
        _ = todoMigrationService.todoService.insertDay(date: previousDay)
        _ = todoMigrationService.todoService.insertDay()

        XCTAssertFalse(todoMigrationService.shouldShowPopup())

        userDefaults.set(previousLaunchDate, forKey: "lastLaunchDate")
    }

    func testShowMigrationPopup_NewDay_HasTodos() throws {
        let previousLaunchDate = userDefaults.object(forKey: "lastLaunchDate") as? Date
        let previousDay = try XCTUnwrap(Calendar.current.date(byAdding: .day, value: -1, to: Date()))
        userDefaults.set(previousDay, forKey: "lastLaunchDate")
        let previousDayId = try XCTUnwrap(todoMigrationService.todoService.insertDay(date: previousDay))
        _ = todoMigrationService.todoService.insertTodo(description: "test", for: previousDayId)
        _ = todoMigrationService.todoService.insertDay()

        XCTAssertTrue(todoMigrationService.shouldShowPopup())

        userDefaults.set(previousLaunchDate, forKey: "lastLaunchDate")
    }
}
