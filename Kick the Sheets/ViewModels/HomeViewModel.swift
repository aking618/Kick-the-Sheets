//
//  HomeViewModel.swift
//  Kick the Sheets
//
//  Created by Ayren King on 2/7/23.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var viewDidLoad: Bool = false

    @Binding var days: [Day]
    @Published var dateSelected: Date = .init()

    // broken
    init(days: Binding<[Day]>) {
        _days = days
    }

    func getStreakCount() -> Int {
        guard !days.isEmpty else { return 0 }

        let sortedDays = days.sorted(by: { $0.date < $1.date })
        let currentDate = Date()
        var streak = 0

        var previousDay: Day?
        for day in sortedDays {
            guard let prevDay = previousDay else {
                streak = day.status ? 1 : 0
                previousDay = day
                continue
            }

            let calendar = Calendar.current
            guard calendar.isDate(prevDay.date, inSameDayAs: calendar.date(byAdding: .day, value: -1, to: day.date)!) else {
                break
            }

            if day.status {
                streak += 1
            } else {
                break
            }

            previousDay = day
        }

        return streak
    }

    func refreshDays() {
        days = TodoDataStore.shared.getAllDays()
    }

    func viewDidLoad(completion: @escaping () -> Void) {
        guard !viewDidLoad else { return }

        viewDidLoad = true
        completion()
    }
}

extension HomeViewModel {
    var dayForSelectedDate: Day? {
        days.first { $0.date.isSameDay(comparingTo: dateSelected) }
    }

    var totalCountForSelectedDate: Int {
        guard let dayForSelectedDate else { return 0 }
        let todos = TodoDataStore.shared.getTodosForDayById(dayId: dayForSelectedDate.id)
        return todos.count
    }

    var completedCountForSelectedDate: Int {
        guard let dayForSelectedDate else { return 0 }
        let todos = TodoDataStore.shared.getTodosForDayById(dayId: dayForSelectedDate.id)
        return Todo.completedCount(from: todos)
    }
}
