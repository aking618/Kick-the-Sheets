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

    var body: some View {
        Text("\(date.dateNumber)")
            .ktsFont(.body)
            .frame(width: 30, height: 30)
            .background(backgroundColor)
            .foregroundColor(foregroundColor)
            .clipShape(Circle())
            .overlay(Circle().stroke(borderColor, lineWidth: borderWidth))
            .onTapGesture {
                selectedDate = date
            }
    }
}

// MARK: - Computed Properties

extension CalendarCell {
    var foregroundColor: Color {
        guard monthPosition == .current else {
            return KTSColors.text.color.opacity(0.3)
        }

        return KTSColors.text.color
    }

    var backgroundColor: Color {
        date.backgroundColor(appState.days)
    }

    var borderColor: Color {
        date.isSameDay(as: selectedDate) ? KTSColors.charcoal.color : KTSColors.border.color
    }

    var borderWidth: CGFloat {
        date.isSameDay(as: selectedDate) ? 1.5 : 1
    }
}

struct CalendarCellPreview_Previews: PreviewProvider {
    static var previews: some View {
        BaseView {
            CalendarView(selectedDate: .constant(Date()))
                .environmentObject(AppState())
        }
    }
}
