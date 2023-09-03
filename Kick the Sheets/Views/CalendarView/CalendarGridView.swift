//
//  CalendarGridView.swift
//  Kick the Sheets
//
//  Created by Ayren King on 9/1/23.
//

import SwiftUI

struct CalendarGridView: View {
    @Binding var selectedDate: Date
    @Binding var currentMonth: Date

    private let calendarGridHelper = CalendarHelper()

    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(), count: 7), content: {
            ForEach(WeekDays.allCases, id: \.id) {
                Text($0.rawValue)
                    .ktsFont(.body)
                    .padding(.top, 1)
                    .lineLimit(1)
            }

            ForEach(calendarGridHelper.getCalendarGrid(for: currentMonth), id: \.self) { date in
                let monthPosition = date.getMonthPosition(relativeTo: currentMonth)
                CalendarCell(date: date, monthPosition: monthPosition, selectedDate: $selectedDate)
            }
        })
    }
}
