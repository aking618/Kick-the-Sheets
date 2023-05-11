//
//  ContentViewModel.swift
//  Kick the Sheets
//
//  Created by Ayren King on 4/2/23.
//

import SwiftUI

class ContentViewModel: ObservableObject {
    
    @Published var selectedTab: Tab = Tab.settings
    @Published var currentDayId: Int64 = 0
    @Published var todosForToday: [Todo] = []
    @Published var days: [Day] = []
    
    @Published var calendarTransition: AnyTransition = .backslide
    
    init() {
        days = TodoDataStore.shared.getAllDays()
        if let currenDay = days.first(where: {
            $0.date.isSameDay(comparingTo: Date())
        }) {
            currentDayId = currenDay.id
            todosForToday =
                TodoDataStore.shared.getTodosForDayById(dayId: currenDay.id)
        } else {
            createDayIfNeeded()
        }
    }
    
    func createDayIfNeeded() {
        if let currentDayId = TodoDataStore.shared.insertDay() {
            self.currentDayId = currentDayId
        }
    }
}
