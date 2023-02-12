//
//  TodoDataStore.swift
//  Database
//
//  Created by Ayren King on 1/21/23.
//

import Foundation
import SQLite

protocol TodoService {
    func insertDay() -> Int64?
    func insertTodoForDayById(description: String, for dayId: Int64) -> Int64?
    func updateDayCompletion(for dayId: Int64, with completion: Bool) -> Bool
    func updateTodo(entry: Todo) -> Bool
    func getTodosForDayById(dayId: Int64) -> [Todo]
    func getAllDays() -> [Day]
    func deleteTodo(entry: Todo) -> Bool
}

public class TodoDataStore: TodoService {
    static let DIR_TASK_DB = "TaskDB"
    static let STORE_NAME = "task.sqlite3"
    
    static public let shared = TodoDataStore()
    
    private var db: Connection? = nil
    
    private let dbDay = DbDay()
    private let dbTodo = DbTodo()
    
    // MARK: - Initializer
    init() {
        if let docDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let dirPath = docDir.appendingPathComponent(Self.DIR_TASK_DB)

            do {
                try FileManager.default.createDirectory(atPath: dirPath.path, withIntermediateDirectories: true, attributes: nil)
                let dbPath = dirPath.appendingPathComponent(Self.STORE_NAME).path
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
    internal func insertDay() -> Int64? {
        guard let database = db else { return nil }
        
        let insert = dbDay.table.insert(
            dbDay.day <- Date(),
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
    
    internal func insertTodoForDayById(description: String, for dayId: Int64) -> Int64? {
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
    internal func getTodosForDayById(dayId: Int64) -> [Todo] {
        var todos = [Todo]()
        guard let database = db else { return todos }
        
        let filter = dbTodo.table.filter(dbTodo.dayId == dayId)
        do {
            for todo in try database.prepare(filter) {
                todos.append(Todo(
                    id: todo[dbTodo.id],
                    dayId: todo[dbTodo.dayId],
                    description: todo[dbTodo.description],
                    status: todo[dbTodo.status])
                )
            }
        } catch {
            print(error)
        }
        return todos
    }
    
    internal func getAllDays() -> [Day] {
        var days: [Day] = []
        guard let database = db else { return [] }
        
        do {
            for day in try database.prepare(self.dbDay.table) {
                days.append(
                    Day(
                        id: day[self.dbDay.id],
                        date: day[self.dbDay.day],
                        status: day[self.dbDay.status]
                    )
                )
            }
        } catch {
            print(error)
        }
        print("[+] Days retrieved successfully")
        return days
    }
    
    // MARK: - Update
    internal func updateDayCompletion(for dayId: Int64, with completion: Bool) -> Bool {
        guard let database = db else { return false }
        
        let day = dbDay.table.filter(dbDay.id == dayId)
        do {
            let update = day.update([
                dbDay.status <- completion
            ])
            if try database.run(update) > 0 {
                return true
            }
        } catch {
            print(error)
        }
        return false
    }
    
    
    internal func updateTodo(entry: Todo) -> Bool {
        guard let database = db else { return false }
        
        let todo = dbTodo.table.filter(dbTodo.id == entry.id)
        do {
            let update = todo.update([
                dbTodo.description <- entry.description,
                dbTodo.status <- entry.status
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
    internal func deleteTodo(entry: Todo) -> Bool {
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
    
    internal func deleteDaysWithIds(ids: [Int64]) {
        guard let database = db else { return }
        
        for id in ids {
            let todo = dbDay.table.filter(dbDay.id == id)
            do {
                if try database.run(todo.delete()) > 0 {
                    print("Removed \(id)")
                }
            } catch {
                print(error)
            }
        }
    }
}
