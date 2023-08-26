//
//  AppState.swift
//  Kick the Sheets
//
//  Created by Ayren King on 7/19/23.
//

import SwiftUI

class AppState: ObservableObject {
    let todoService: TodoService
    let todoMigrationService: TodoMigrationService

    @Published var path = NavigationPath()
    @Published var selectedTab: Tab = .home
    @Published var currentDayId: Int64 = 0
    @Published var todosForToday: [Todo] = []
    @Published var days: [Day] = []
    @Published var showMigrationPopup: Bool = false

    @Published var calendarTransition: AnyTransition = .backslide

    init(todoService: TodoService = GeneralTodoService()) {
        self.todoService = todoService
        todoMigrationService = TodoMigrationService(todoService: todoService)

        updateAppState()
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
