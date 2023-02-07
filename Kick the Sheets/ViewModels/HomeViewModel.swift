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
}

