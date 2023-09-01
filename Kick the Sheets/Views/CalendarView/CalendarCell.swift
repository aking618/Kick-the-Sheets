//
//  CalendarCell.swift
//  Kick the Sheets
//
//  Created by Ayren King on 9/1/23.
//

import SwiftUI

struct CalendarCell: View {
    let date: Date
    let monthPosition: MonthPosition // this is in reference to what month is being displayed
    @Binding var selectedDate: Date

    @EnvironmentObject var appState: AppState

    var foregroundColor: Color {
        guard monthPosition == .current else {
            return .gray
        }

        return date.isSameDay(as: selectedDate) ? .white : .black
    }

    var backgroundColor: Color {
        return date.backgroundColor(appState.days)
    }

    var borderColor: Color {
        guard monthPosition == .current else {
            return .gray
        }

        return date.isSameDay(as: selectedDate) ? .blue : .gray
    }

    var body: some View {
        Text("\(date.dateNumber)")
            .foregroundColor(foregroundColor)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .contentShape(Circle())
            .padding(4)
            .background(backgroundColor)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(borderColor, lineWidth: 1)
            )
            .onTapGesture {
                selectedDate = date
            }
    }
}
