//
//  AppState.swift
//  Kick the Sheets
//
//  Created by Ayren King on 7/19/23.
//

import SwiftUI

class AppState: ObservableObject {
    let todoService: TodoService = GeneralTodoService()

    @Published var path = NavigationPath()
    @Published var selectedTab: Tab = .home
    @Published var currentDayId: Int64 = 0
    @Published var todosForToday: [Todo] = []
    @Published var days: [Day] = []
    @Published var showMigrationPopup: Bool = false

    @Published var calendarTransition: AnyTransition = .backslide

    init() {
        updateAppState()
    }

    func shouldShowMigrationPopup() -> Bool {
        let currentDate = Date()
        let userDefaults = UserDefaults.standard

        guard UserDefaults.standard.object(forKey: "migrateTodos") as? Bool ?? false else { return false }

        guard days.count > 1 else { return false }

        let days = todoService.retrieveDays()
        guard let previousDay = days.last(where: {
            !Calendar.current.isDate($0.date, inSameDayAs: Date())
        }),
            !previousDay.status
        else {
            return false
        }

        if let lastPopupDate = userDefaults.object(forKey: "lastPopupDate") as? Date {
            return !lastPopupDate.isSameDay(comparingTo: currentDate)
        } else {
            return true
        }
    }

    func updateLastPopupDate() {
        let currentDate = Date()
        let userDefaults = UserDefaults.standard
        userDefaults.set(currentDate, forKey: "lastPopupDate")
    }

    func handleTodoMigration() {
        guard todosForToday.isEmpty else { return }

        let days = todoService.retrieveDays()
        guard let previousDay = days.last(where: {
            !Calendar.current.isDate($0.date, inSameDayAs: Date())
        }) else {
            return
        }

        let todos = todoService.retrieveTodos(for: previousDay.id)

        for todo in todos {
            guard !todo.status else { return }
            _ = todoService.insertTodo(description: todo.description, for: currentDayId)
        }
        todosForToday = todoService.retrieveTodos(for: currentDayId)
    }

    func updateAppState() {
        days = todoService.retrieveDays()
        if let currenDay = days.first(where: {
            $0.date.isSameDay(comparingTo: Date())
        }) {
            currentDayId = currenDay.id
            todosForToday =
                todoService.retrieveTodos(for: currenDay.id)
        } else {
            createDayIfNeeded()
        }
    }

    func createDayIfNeeded() {
        if let currentDayId = todoService.insertDay() {
            self.currentDayId = currentDayId
            todosForToday = []
        }
    }
}

extension AppState {
    func navigate(to destination: any Hashable) {
        path.append(destination)
    }

    func pop() {
        path.removeLast()
    }
}
