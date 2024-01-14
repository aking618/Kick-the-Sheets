//
//  TodoMigrationServiceTests.swift
//  Kick the SheetsTests
//
//  Created by Ayren King on 8/22/23.
//

import XCTest

@testable import KTS
@testable import Services

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

    func testShowMigrationPopup_MigrateTodosFalse() throws {
        let previousMigrateTodos = userDefaults.object(forKey: "migrateTodos") as? Bool
        userDefaults.set(false, forKey: "migrateTodos")

        XCTAssertFalse(todoMigrationService.shouldShowPopup())

        userDefaults.set(previousMigrateTodos, forKey: "migrateTodos")
    }

    func testShowMigrationPopup_FirstLaunch() throws {
        let previousMigrateTodos = userDefaults.object(forKey: "migrateTodos") as? Bool
        userDefaults.set(true, forKey: "migrateTodos")
        let previousLaunchDate = userDefaults.object(forKey: "lastLaunchDate") as? Date
        userDefaults.set(nil, forKey: "lastLaunchDate")

        XCTAssertFalse(todoMigrationService.shouldShowPopup())

        userDefaults.set(previousMigrateTodos, forKey: "migrateTodos")
        userDefaults.set(previousLaunchDate, forKey: "lastLaunchDate")
    }

    func testShowMigrationPopup_SameDay() throws {
        let previousMigrateTodos = userDefaults.object(forKey: "migrateTodos") as? Bool
        userDefaults.set(true, forKey: "migrateTodos")
        let previousLaunchDate = userDefaults.object(forKey: "lastLaunchDate") as? Date
        userDefaults.set(Date(), forKey: "lastLaunchDate")

        XCTAssertFalse(todoMigrationService.shouldShowPopup())

        userDefaults.set(previousMigrateTodos, forKey: "migrateTodos")
        userDefaults.set(previousLaunchDate, forKey: "lastLaunchDate")
    }

    func testShowMigrationPopup_NewDay_NoTodos() throws {
        let previousMigrateTodos = userDefaults.object(forKey: "migrateTodos") as? Bool
        userDefaults.set(true, forKey: "migrateTodos")
        let previousLaunchDate = userDefaults.object(forKey: "lastLaunchDate") as? Date
        let previousDay = try XCTUnwrap(Calendar.current.date(byAdding: .day, value: -1, to: Date()))
        userDefaults.set(previousDay, forKey: "lastLaunchDate")
        _ = todoMigrationService.todoService.insertDay(date: previousDay)
        _ = todoMigrationService.todoService.insertDay()

        XCTAssertFalse(todoMigrationService.shouldShowPopup())

        userDefaults.set(previousMigrateTodos, forKey: "migrateTodos")
        userDefaults.set(previousLaunchDate, forKey: "lastLaunchDate")
    }

    func testShowMigrationPopup_NewDay_HasTodos() throws {
        let previousMigrateTodos = userDefaults.object(forKey: "migrateTodos") as? Bool
        userDefaults.set(true, forKey: "migrateTodos")
        let previousLaunchDate = userDefaults.object(forKey: "lastLaunchDate") as? Date
        let previousDay = try XCTUnwrap(Calendar.current.date(byAdding: .day, value: -1, to: Date()))
        userDefaults.set(previousDay, forKey: "lastLaunchDate")
        let previousDayId = try XCTUnwrap(todoMigrationService.todoService.insertDay(date: previousDay))
        _ = todoMigrationService.todoService.insertTodo(description: "test", for: previousDayId)
        _ = todoMigrationService.todoService.insertDay()

        XCTAssertTrue(todoMigrationService.shouldShowPopup())

        userDefaults.set(previousMigrateTodos, forKey: "migrateTodos")
        userDefaults.set(previousLaunchDate, forKey: "lastLaunchDate")
    }

    func testMigrateTodos_AllIncomplete() throws {
        let previousDay = try XCTUnwrap(Calendar.current.date(byAdding: .day, value: -1, to: Date()))
        let previousDayId = try XCTUnwrap(todoMigrationService.todoService.insertDay(date: previousDay))
        let currentDayId = try XCTUnwrap(todoMigrationService.todoService.insertDay())

        for dummyTask in dummyTaskDescriptions {
            _ = todoMigrationService.todoService.insertTodo(description: dummyTask, for: previousDayId)
        }

        XCTAssertTrue(todoMigrationService.todoService.retrieveTodos(for: currentDayId).isEmpty)
        todoMigrationService.migrateTodos(currentDayId: currentDayId)

        XCTAssertEqual(todoMigrationService.todoService.retrieveTodos(for: currentDayId).count, 4)
    }

    func testMigrateTodos_SomeIncomplete() throws {
        let previousDay = try XCTUnwrap(Calendar.current.date(byAdding: .day, value: -1, to: Date()))
        let previousDayId = try XCTUnwrap(todoMigrationService.todoService.insertDay(date: previousDay))
        let currentDayId = try XCTUnwrap(todoMigrationService.todoService.insertDay())

        for dummyTask in dummyTaskDescriptions {
            let todoId = try XCTUnwrap(todoMigrationService.todoService.insertTodo(description: dummyTask, for: previousDayId))
            if dummyTask == "Mario" {
                var todo = try XCTUnwrap(todoMigrationService.todoService.retrieveTodo(for: todoId), "Unable to retrieve todo")
                todo.status = true
                _ = todoMigrationService.todoService.updateTodo(entry: todo)
            }
        }

        var todos = todoMigrationService.todoService.retrieveTodos(for: currentDayId)

        XCTAssertTrue(todos.isEmpty)
        todoMigrationService.migrateTodos(currentDayId: currentDayId)

        todos = todoMigrationService.todoService.retrieveTodos(for: currentDayId)

        XCTAssertEqual(todos.count, 3)
        XCTAssertFalse(todos.contains { $0.description == "Mario" })
    }
}

extension TodoMigrationServiceTests {
    private var dummyTaskDescriptions: [String] {
        ["Mario", "Luigi", "Peach", "Yoshi"]
    }
}
