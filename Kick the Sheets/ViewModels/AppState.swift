//
//  AppState.swift
//  Kick the Sheets
//
//  Created by Ayren King on 7/19/23.
//

import SwiftUI

class AppState: ObservableObject {
    let todoService: TodoService = GeneralTodoService()

    @Published var selectedTab: Tab = .home
    @Published var currentDayId: Int64 = 0
    @Published var todosForToday: [Todo] = []
    @Published var days: [Day] = []

    @Published var calendarTransition: AnyTransition = .backslide

    init() {
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