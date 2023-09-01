//
//  CalendarView.swift
//  Kick the Sheets
//
//  Created by Ayren King on 8/28/23.
//

import SwiftUI

struct CalendarView: View {
    @Binding var selectedDate: Date
    @State var currentMonth: Date = .init()

    init(selectedDate: Binding<Date>) {
        _selectedDate = selectedDate
    }

    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    if let previousMonth = Calendar.current.date(byAdding: .month, value: -1, to: currentMonth) {
                        currentMonth = previousMonth
                    }
                }, label: {
                    Image(systemName: "chevron.left")
                })
                Spacer()
                Text("\(currentMonth.month.description)")
                    .ktsFont(.title)
                Spacer()
                Button(action: {
                    if let nextMonth = Calendar.current.date(byAdding: .month, value: 1, to: currentMonth) {
                        currentMonth = nextMonth
                    }
                }, label: {
                    Image(systemName: "chevron.right")
                })
            }
            CalendarGridView(selectedDate: $selectedDate, currentMonth: $currentMonth)
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView(selectedDate: .constant(Date()))
    }
}
