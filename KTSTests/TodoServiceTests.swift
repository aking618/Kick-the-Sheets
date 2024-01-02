//
//  TodoServiceTests.swift
//  Kick the SheetsTests
//
//  Created by Ayren King on 8/10/23.
//

import XCTest

@testable import KTS
@testable import Services

final class TodoServiceTests: XCTestCase {
    var todoService: TodoService!
    let fileManager: FileManager = .default

    let DIR_TASK_DB = "TaskDemoDB"
    let STORE_NAME = "taskDemo.sqlite3"

    override func setUp() {
        todoService = GeneralTodoService(directory: "TaskDemoDB", store: "taskDemo.sqlite3")
    }

    override func tearDown() {
        todoService.deleteAllEntries()

        todoService = nil
    }

    func testInit() {
        if let docDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
            let dbPath = docDir
                .appending(path: DIR_TASK_DB)
                .appending(path: STORE_NAME)

            try? fileManager.removeItem(at: dbPath)

            XCTAssertFalse(fileManager.fileExists(atPath: dbPath.path))

            todoService = GeneralTodoService(directory: "TaskDemoDB", store: "taskDemo.sqlite3")

            XCTAssertTrue(fileManager.fileExists(atPath: dbPath.path))
        } else {
            XCTFail("Unable to get doc directory")
        }
    }

    func testInsertDay() {
        XCTAssertTrue(todoService.retrieveDays().isEmpty)

        _ = todoService.insertDay()

        XCTAssertEqual(todoService.retrieveDays().count, 1)
    }

    func testInsertTodo() throws {
        let dayId = try XCTUnwrap(todoService.insertDay(), "Error inserting day")

        let todoId = todoService.insertTodo(description: "Test", for: dayId)

        XCTAssertNotNil(todoId)
    }

    func testRetrieveTodos() throws {
        let dayId = try XCTUnwrap(todoService.insertDay(), "Error inserting day")

        _ = todoService.insertTodo(description: "Test", for: dayId)

        XCTAssertEqual(todoService.retrieveTodos(for: dayId).count, 1)
    }

    func testRetrieveTodoById_Exist() throws {
        let dayId = try XCTUnwrap(todoService.insertDay())
        let todoId = try XCTUnwrap(todoService.insertTodo(description: "Test", for: dayId))

        let todo = todoService.retrieveTodo(for: todoId)

        XCTAssertEqual(todoId, todo?.id)
    }

    func testRetrieveTodoById_DoesNotExist() throws {
        XCTAssertNil(todoService.retrieveTodo(for: 0))
    }

    func testUpdateDayCompletion() throws {
        let dayId = try XCTUnwrap(todoService.insertDay())
        var day = try XCTUnwrap(todoService.retrieveDays()[Date().key])
        XCTAssertFalse(day.status)

        XCTAssertTrue(todoService.updateDayCompletion(for: dayId, with: true))

        day = try XCTUnwrap(todoService.retrieveDays()[Date().key])
        XCTAssertTrue(day.status)
    }

    func testUpdateTodo() throws {
        _ = try XCTUnwrap(todoService.insertTodo(description: "test", for: 0))
        var todo = try XCTUnwrap(todoService.retrieveTodos(for: 0).first)
        XCTAssertEqual(todo.description, "test")

        todo.description = "new test"
        XCTAssertTrue(todoService.updateTodo(entry: todo))

        todo = try XCTUnwrap(todoService.retrieveTodos(for: 0).first)
        XCTAssertEqual(todo.description, "new test")
    }

    func testRetrieveSecondMostRecentDay_NoEntries() throws {
        let secondMostRecentDay = todoService.retrieveSecondMostRecentDay()

        XCTAssertNil(secondMostRecentDay)
    }

    func testRetrieveSecondMostRecentDay_OneDay() throws {
        let dayId = try XCTUnwrap(todoService.insertDay())

        let secondMostRecentDay = todoService.retrieveSecondMostRecentDay()

        XCTAssertNil(secondMostRecentDay)
    }

    func testRetrieveSecondMostRecentDay_ConsecutiveDays() throws {
        let previousDay = try XCTUnwrap(Calendar.current.date(byAdding: .day, value: -1, to: Date()))

        let previousDayId = todoService.insertDay(date: previousDay)
        _ = todoService.insertDay()

        let secondMostRecentDay = todoService.retrieveSecondMostRecentDay()

        XCTAssertEqual(previousDayId, secondMostRecentDay?.id)
    }

    func testRetrieveSecondMostRecentDay_NonConsecutiveDays() throws {
        var previousDay = try XCTUnwrap(Calendar.current.date(byAdding: .day, value: -5, to: Date()))
        _ = todoService.insertDay(date: previousDay)
        previousDay = try XCTUnwrap(Calendar.current.date(byAdding: .day, value: -3, to: Date()))
        let previousDayId = todoService.insertDay(date: previousDay)
        _ = todoService.insertDay()

        let secondMostRecentDay = todoService.retrieveSecondMostRecentDay()

        XCTAssertEqual(previousDayId, secondMostRecentDay?.id)
    }

    func testDeleteTodo() throws {
        let dayId = try XCTUnwrap(todoService.insertDay())
        let todoId = try XCTUnwrap(todoService.insertTodo(description: "test", for: dayId))

        let todo = try XCTUnwrap(todoService.retrieveTodo(for: todoId), "Unable to create todo")

        XCTAssertTrue(todoService.deleteTodo(entry: todo))
        XCTAssertNil(todoService.retrieveTodo(for: todoId))
    }

    func testDeleteAllEntries() throws {
        _ = todoService.insertDay()

        todoService.deleteAllEntries()

        XCTAssertTrue(todoService.retrieveDays().isEmpty)
    }
}
