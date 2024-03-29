//
//  TodoDataStore.swift
//  Database
//
//  Created by Ayren King on 1/21/23.
//

import Foundation
import SQLite

public protocol TodoService {
    func insertDay(date: Date) -> Int64?
    func insertTodo(description: String, for dayId: Int64) -> Int64?
    func updateDayCompletion(for dayId: Int64, with completion: Bool) -> Bool
    func updateTodo(entry: Todo) -> Bool
    func retrieveTodos(for dayId: Int64) -> [Todo]
    func retrieveTodo(for todoId: Int64) -> Todo?
    func retrieveSecondMostRecentDay() -> Day?
    func retrieveDays() -> [Int: Day]
    func deleteTodo(entry: Todo) -> Bool
    func deleteAllEntries()
}

extension TodoService {
    func insertDay(date: Date = Date()) -> Int64? {
        insertDay(date: date)
    }
}

public class GeneralTodoService: TodoService {
    private var db: Connection? = nil

    private let dbDay = DbDay()
    private let dbTodo = DbTodo()

    // MARK: - Initializer

    public init(directory: String = "TaskDB", store: String = "task.sqlite3") {
        if let docDir = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.ayrenking.KTS") {
            let dirPath = docDir.appendingPathComponent(directory)

            do {
                try FileManager.default.createDirectory(atPath: dirPath.path, withIntermediateDirectories: true, attributes: nil)
                let dbPath = dirPath.appendingPathComponent(store).path
                db = try Connection(dbPath)
                createTables()
                print("SQLiteDataStore init successfully at: \(dbPath) ")
            } catch {
                db = nil
                print("SQLiteDataStore init error: \(error)")
            }
        } else {
            db = nil
        }
    }

    // Create db
    private func createTables() {
        guard let database = db else { return }
        do {
            try database.run(dbDay.table.create { t in
                t.column(dbDay.id, primaryKey: .autoincrement)
                t.column(dbDay.day)
                t.column(dbDay.status)
            })

            try database.run(dbTodo.table.create { t in
                t.column(dbTodo.id, primaryKey: .autoincrement)
                t.column(dbTodo.dayId)
                t.column(dbTodo.status)
                t.column(dbTodo.description)

                t.foreignKey(dbTodo.dayId, references: dbDay.table, dbTodo.id, update: .cascade, delete: .cascade)
            })
            print("[+] Tables created...")
        } catch {
            print(error)
        }
    }

    // MARK: - Create

    public func insertDay(date: Date = Date()) -> Int64? {
        guard let database = db else { return nil }

        let insert = dbDay.table.insert(
            dbDay.day <- date,
            dbDay.status <- false
        )

        do {
            let rowID = try database.run(insert)
            return rowID
        } catch {
            print(error)
            return nil
        }
    }

    public func insertTodo(description: String, for dayId: Int64) -> Int64? {
        guard let database = db else { return nil }

        let insert = dbTodo.table.insert(
            dbTodo.dayId <- dayId,
            dbTodo.description <- description,
            dbTodo.status <- false
        )

        do {
            let rowID = try database.run(insert)
            return rowID
        } catch {
            print(error)
            return nil
        }
    }

    // MARK: - Retrieve

    public func retrieveTodos(for dayId: Int64) -> [Todo] {
        var todos = [Todo]()
        guard let database = db else { return todos }

        let filter = dbTodo.table.filter(dbTodo.dayId == dayId)
        do {
            for todo in try database.prepare(filter) {
                todos.append(Todo(
                    id: todo[dbTodo.id],
                    dayId: todo[dbTodo.dayId],
                    description: todo[dbTodo.description],
                    status: todo[dbTodo.status]
                )
                )
            }
        } catch {
            print(error)
        }
        return todos
    }

    public func retrieveTodo(for todoId: Int64) -> Todo? {
        guard let database = db else { return nil }

        let filter = dbTodo.table.filter(dbTodo.id == todoId).limit(1)
        do {
            let todos = try database.prepare(filter)

            let iterator = todos.makeIterator()

            if let todo = iterator.next() {
                return Todo(
                    id: todo[dbTodo.id],
                    dayId: todo[dbTodo.dayId],
                    description: todo[dbTodo.description],
                    status: todo[dbTodo.status]
                )
            }
        } catch {
            print(error)
        }

        return nil
    }

    public func retrieveDays() -> [Int: Day] {
        var days: [Int: Day] = [:]
        guard let database = db else { return [:] }

        do {
            for day in try database.prepare(dbDay.table) {
                let date = day[dbDay.day]
                let key = date.key

                days[key] = Day(
                    id: day[dbDay.id],
                    date: date,
                    status: day[dbDay.status]
                )
            }
        } catch {
            print(error)
        }
        print("[+] Days retrieved successfully")
        return days
    }

    public func retrieveSecondMostRecentDay() -> Day? {
        guard let database = db else { return nil }

        do {
            let sortedDays = try database.prepare(dbDay.table.order(dbDay.day.desc).limit(1, offset: 1))

            let iterator = sortedDays.makeIterator()

            if let secondMostRecentDay = iterator.next() {
                return Day(
                    id: secondMostRecentDay[dbDay.id],
                    date: secondMostRecentDay[dbDay.day],
                    status: secondMostRecentDay[dbDay.status]
                )
            }
        } catch {
            print(error)
        }

        return nil
    }

    // MARK: - Update

    public func updateDayCompletion(for dayId: Int64, with completion: Bool) -> Bool {
        guard let database = db else { return false }

        let day = dbDay.table.filter(dbDay.id == dayId)
        do {
            let update = day.update([
                dbDay.status <- completion,
            ])
            if try database.run(update) > 0 {
                return true
            }
        } catch {
            print(error)
        }
        return false
    }

    public func updateTodo(entry: Todo) -> Bool {
        guard let database = db else { return false }

        let todo = dbTodo.table.filter(dbTodo.id == entry.id)
        do {
            let update = todo.update([
                dbTodo.description <- entry.description,
                dbTodo.status <- entry.status,
            ])
            if try database.run(update) > 0 {
                return true
            }
        } catch {
            print(error)
        }
        return false
    }

    // MARK: - Delete

    public func deleteTodo(entry: Todo) -> Bool {
        guard let database = db else { return false }

        var result = false
        let todo = dbTodo.table.filter(dbTodo.id == entry.id)
        do {
            if try database.run(todo.delete()) > 0 {
                result = true
            }
        } catch {
            print(error)
        }
        return result
    }

    public func deleteAllEntries() {
        guard let database = db else { return }
        do {
            try database.run(dbDay.table.drop())
            try database.run(dbTodo.table.drop())
            createTables()
            print("Tables reset successfully.")
        } catch {
            print("Error resetting tables: \(error)")
        }
    }
}

// MARK: - DEMO DATA

extension GeneralTodoService {
    func createDemoDayRecords() {
        let days = generateDays(numDays: 25)

        guard let database = db else { return }

        for day in days {
            let insert = dbDay.table.insert(
                dbDay.day <- day.date,
                dbDay.status <- day.status
            )

            do {
                _ = try database.run(insert)
            } catch {
                print(error)
                return
            }
        }
    }

    func createDemoTodoRecords(for dayId: Int64) {
        let tasks = [
            "Complete Project Proposal",
            "Prepare Presentation Slides",
            "Review Feedback",
            "Submit Final Report",
            "Send Thank You Email",
        ]

        for task in tasks {
            _ = insertTodo(description: task, for: dayId)
        }
    }

    func generateDays(numDays: Int) -> [Day] {
        var days: [Day] = []

        let calendar = Calendar.current
        let startDate = calendar.date(byAdding: .day, value: -1, to: Date())!

        for i in 0 ..< numDays {
            let currentDate = calendar.date(byAdding: .day, value: -i, to: startDate)!
            let randomStatus = Double.random(in: 0 ..< 1) < 0.8

            let day = Day(id: Int64(i + 1), date: currentDate, status: randomStatus)
            days.append(day)
        }

        return days
    }
}
