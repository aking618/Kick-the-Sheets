//
//  CalendarWrapperView.swift
//  Kick the Sheets
//
//  Created by Ayren King on 2/16/23.
//

import SelectableCalendarView
import SwiftUI

struct CalendarWrapperView: View {
    
    @Binding var days: [Day]
    @Binding var selectedDate: Date
    
    var body: some View {
        SelectableCalendarView(
            monthToDisplay: Date(),
            dateSelected: $selectedDate,
            dateBackgroundBuilder: { date in
                AnyView(
                    Circle()
                        .foregroundColor(date.backgroundColor(days))
                        .frame(width: 35, height: 35)
                     )
            },
            dateForgroundBuilder: {date in
                // TODO: Change to NavLink to show previous days
                AnyView(
                    Text("\(date.calendarDay)")
                        .foregroundColor(date.foregroundColor(days))
                )
            }
        ){ date in date.backgroundColor(days) }
            .foregroundColor(KTSColors.textColor.color)
            .padding(.bottom)
            .ktcFont(.body)
    }
}
