//
//  CalendarView.swift
//  Kick the Sheets
//
//  Created by Ayren King on 8/28/23.
//

import SwiftUI

struct CalendarView: View {
    @StateObject var viewModel = CalendarViewModel()

    @Binding var selectedDate: Date

    init(selectedDate: Binding<Date>) {
        _selectedDate = selectedDate
    }

    var body: some View {
        VStack {
            HStack {
                previousMonthButton
                Spacer()
                currentMonthLabel
                Spacer()

                if viewModel.showNextMonthButton {
                    futureMonthButton
                }
            }
            CalendarGridView(selectedDate: $selectedDate, currentMonth: $viewModel.currentMonth)
        }
    }
}

// MARK: - Views

extension CalendarView {
    var previousMonthButton: some View {
        Button(action: viewModel.updateToPrevMonth, label: {
            Image(systemName: "chevron.left")
        })
    }

    var futureMonthButton: some View {
        Button(action: viewModel.updateToNextMonth, label: {
            Image(systemName: "chevron.right")
        })
    }

    var currentMonthLabel: some View {
        Text("\(viewModel.currentMonth.month.description)")
            .ktsFont(.title2)
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        BaseView {
            CalendarView(selectedDate: .constant(Date()))
                .environmentObject(AppState())
        }
    }
}
