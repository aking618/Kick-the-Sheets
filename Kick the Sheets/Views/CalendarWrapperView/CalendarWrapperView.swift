//
//  CalendarWrapperView.swift
//  Kick the Sheets
//
//  Created by Ayren King on 2/16/23.
//

import SelectableCalendarView
import SwiftUI

struct CalendarWrapperView: View {
    @Binding var days: [Int: Day]
    @Binding var selectedDate: Date

    var body: some View {
        SelectableCalendarView(
            monthToDisplay: Date(),
            dateSelected: $selectedDate,
            dateBackgroundBuilder: { date in
                AnyView(
                    ZStack {
                        Circle()
                            .foregroundColor(date.backgroundColor(days))
                        Circle()
                            .strokeBorder(KTSColors.charcoal.color, lineWidth: 2)
                            .opacity($selectedDate.wrappedValue.isSameDay(comparingTo: date) ? 1 : 0)
                    }
                    .frame(width: 35, height: 35)
                )
            },
            dateForgroundBuilder: { date in
                AnyView(
                    Text("\(date.calendarDay)")
                        .foregroundColor(date.foregroundColor(days))
                )
            }
        ) { date in date.backgroundColor(days) }
            .foregroundColor(KTSColors.text.color)
            .padding(.bottom)
            .ktsFont(.body)
    }
}
