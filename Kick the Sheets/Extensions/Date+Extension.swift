//
//  Date+Extension.swift
//  Kick the Sheets
//
//  Created by Ayren King on 12/22/22.
//

import Foundation
import SwiftUI

extension Date {
    var key: Int {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        return Int(formatter.string(from: self)) ?? 0
    }

    func backgroundColor(_ days: [Int: Day]) -> Color {
        if isSameDay(as: Date()) {
            return KTSColors.saffron.color
        }

        if self > Date() {
            return KTSColors.iconBorder.color
        }

        if let day = days[key] {
            return day.status ? KTSColors.persianGreen.color : KTSColors.burntSienna.color
        }

        return KTSColors.iconBorder.color
    }

    func foregroundColor(_ days: [Int: Day]) -> Color {
        if isSameDay(as: Date()) {
            return KTSColors.text.color
        }

        if self > Date() {
            return KTSColors.text.color
        }

        if days[key] != nil {
            return .white
        }

        return KTSColors.text.color
    }

    var calendarDay: Int {
        Calendar.current.dateComponents([.day], from: self).day ?? 0
    }

    func getDayString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMMM d"
        return formatter.string(from: self)
    }

    func isSameDay(as date: Date) -> Bool {
        return Calendar.current.isDate(self, inSameDayAs: date)
    }

    var dateNumber: Int {
        return Calendar.current.component(.day, from: self)
    }

    var month: Months {
        return Months(rawValue: Calendar.current.component(.month, from: self) - 1)!
    }

    var year: Int {
        return Calendar.current.component(.year, from: self)
    }

    func getMonthPosition(relativeTo date: Date) -> MonthPosition {
        if self < CalendarHelper().getFirstDayOfMonth(for: date) {
            return .previous
        } else if self > CalendarHelper().getLastDayOfMonth(for: date) {
            return .next
        } else {
            return .current
        }
    }
}
