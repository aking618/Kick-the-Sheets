//
//  TodoMigrationService.swift
//  Kick the Sheets
//
//  Created by Ayren King on 8/22/23.
//

import Foundation

final class TodoMigrationService {
    let todoService: TodoService

    init(todoService: TodoService) {
        self.todoService = todoService
    }

    func shouldShowPopup() -> Bool {
        let userDefaults = UserDefaults.standard

        guard userDefaults.bool(forKey: "migrateTodos") else { return false }

        if let lastLaunchDate = userDefaults.object(forKey: "lastLaunchDate") as? Date {
            let calendar = Calendar.current
            if !calendar.isDateInToday(lastLaunchDate) {
                userDefaults.set(Date(), forKey: "lastLaunchDate")
                return hasPreviousData()
            }
            return false
        } else {
            userDefaults.set(Date(), forKey: "lastLaunchDate")
            return false
        }
    }

    private func hasPreviousData() -> Bool {
        var days = todoService.retrieveDays()
        guard let _ = days.popLast(),
              let previousDay = days.popLast()
        else {
            return false
        }

        let todos = todoService.retrieveTodos(for: previousDay.id)

        guard !todos.isEmpty else { return false }

        return true
    }

    private func retrieveTodosToMigrate() -> [Todo] {
        var days = todoService.retrieveDays()
        guard let _ = days.popLast(),
              let previousDay = days.popLast()
        else {
            return []
        }

        let todos = todoService.retrieveTodos(for: previousDay.id)

        return todos.filter { !$0.status }
    }

    func migrateTodos(currentDayId: Int64) {
        let todos = retrieveTodosToMigrate()

        for todo in todos {
            _ = todoService.insertTodo(description: todo.description, for: currentDayId)
        }
    }
}
