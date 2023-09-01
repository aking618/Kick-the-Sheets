//
//  HomeViewModel.swift
//  Kick the Sheets
//
//  Created by Ayren King on 2/7/23.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    let todoService: TodoService

    @Published var viewDidLoad: Bool = false
    @Binding var days: [Day]
    @Published var dateSelected: Date = .init()

    // broken
    init(todoService: TodoService, days: Binding<[Day]>) {
        self.todoService = todoService
        _days = days
    }

    func getStreakCount() -> Int {
        guard !days.isEmpty else { return 0 }

        let sortedDays = days.sorted(by: { $0.date > $1.date }).dropFirst()
        let calendar = Calendar.current
        let yesterday = calendar.date(byAdding: .day, value: -1, to: Date())!
        var consecutiveDays = 0
        var currentDate = yesterday

        for day in sortedDays {
            if calendar.isDate(day.date, inSameDayAs: currentDate) {
                if day.status == false {
                    break
                }

                consecutiveDays += 1
                currentDate = calendar.date(byAdding: .day, value: -1, to: currentDate)!
            } else {
                break
            }
        }

        return consecutiveDays
    }

    func refreshDays() {
        days = todoService.retrieveDays()
    }

    func viewDidLoad(completion: @escaping () -> Void) {
        guard !viewDidLoad else { return }

        viewDidLoad = true
        completion()
    }
}

extension HomeViewModel {
    var dayForSelectedDate: Day? {
        days.first { $0.date.isSameDay(as: dateSelected) }
    }

    var totalCountForSelectedDate: Int {
        guard let dayForSelectedDate else { return 0 }
        let todos = todoService.retrieveTodos(for: dayForSelectedDate.id)
        return todos.count
    }

    var completedCountForSelectedDate: Int {
        guard let dayForSelectedDate else { return 0 }
        let todos = todoService.retrieveTodos(for: dayForSelectedDate.id)
        return Todo.completedCount(from: todos)
    }
}
