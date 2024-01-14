//
//  CalendarViewModel.swift
//  Kick the Sheets
//
//  Created by Ayren King on 9/2/23.
//

import SwiftUI

class CalendarViewModel: ObservableObject {
    @Published var currentMonth: Date = .init()
    @Published var showNextMonthButton: Bool = false

    func updateToPrevMonth() {
        guard let previousMonth = Calendar.current.date(byAdding: .month, value: -1, to: currentMonth)
        else { return }

        currentMonth = previousMonth
        updateShowNextMonthButton()
    }

    func updateToNextMonth() {
        guard let nextMonth = Calendar.current.date(byAdding: .month, value: 1, to: currentMonth)
        else { return }

        currentMonth = nextMonth
        updateShowNextMonthButton()
    }

    func updateShowNextMonthButton() {
        showNextMonthButton = !Calendar.current.isDate(currentMonth, equalTo: Date(), toGranularity: .month)
    }
}
