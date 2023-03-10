//
//  HomeViewModel.swift
//  Kick the Sheets
//
//  Created by Ayren King on 2/7/23.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var currentDayId: Int64?
    @Published var todosForToday: [Todo] = []
    @Published var days: [Day] = []
    @Published var dateSelected: Date = Date()
    
    var buttonText: String {
        currentDayId != nil ? "Continue your day!" : "Start your day!"
    }
    
    init() {
        days = TodoDataStore.shared.getAllDays()
        if let currenDay = days.first(where: {
            $0.date.isSameDay(comparingTo: Date())
        }) {
            currentDayId = currenDay.id
            todosForToday =
                TodoDataStore.shared.getTodosForDayById(dayId: currenDay.id)
        }
    }
    
    func createDayIfNeeded() {
        if currentDayId == nil {
            if let currentDayId = TodoDataStore.shared.insertDay() {
                self.currentDayId = currentDayId
            }
        }
    }
    
    func getStreakCount() -> Int {
        guard !days.isEmpty else { return 0 }
        
        var sortedDays = days.sorted(by: { $0.id > $1.id })
        var day = sortedDays.popLast()!
        var streak = day.status ? 1 : 0;
        while (sortedDays.last != nil) {
            if sortedDays.last!.status {
                streak += 1
            } else {
                break
            }
            _ = sortedDays.popLast()
        }
        
        return streak;
    }
}

