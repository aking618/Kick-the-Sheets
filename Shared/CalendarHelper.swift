//
//  CalendarHelper.swift
//  Kick the Sheets
//
//  Created by Ayren King on 9/1/23.
//

import Foundation

public class CalendarHelper {
    let calendar = Calendar.current

    public init() {}

    /// Returns the first day of the month for the given date
    public func getFirstDayOfMonth(for date: Date) -> Date {
        guard let firstDayOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: date)) else {
            fatalError("Unable to calculate the first day of the month for \(date)")
        }
        return firstDayOfMonth
    }

    /// Returns the last day of the month for the given date
    public func getLastDayOfMonth(for date: Date) -> Date {
        guard let lastDayOfMonth = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: getFirstDayOfMonth(for: date)) else {
            fatalError("Unable to calculate the last day of the month for \(date)")
        }
        return lastDayOfMonth
    }

    /// Returns the number of extra days to be shown from the previous month
    private func getExtraDaysFromPreviousMonth(for date: Date) -> Int {
        return calendar.component(.weekday, from: getFirstDayOfMonth(for: date)) - 1
    }

    /// Returns the number of extra days to be shown from the next month
    private func getExtraDaysFromNextMonth(for date: Date) -> Int {
        return 7 - calendar.component(.weekday, from: getLastDayOfMonth(for: date))
    }

    /// Returns the previous month end date for the given date
    private func getPreviousMonthEndDate(for date: Date) -> Date {
        guard let previousMonthEndDate = calendar.date(byAdding: .day, value: -1, to: getFirstDayOfMonth(for: date)) else {
            fatalError("Unable to calculate the previous month end date for \(date)")
        }
        return previousMonthEndDate
    }

    /// Returns the next month start date for the given date
    private func getNextMonthStartDate(for date: Date) -> Date {
        guard let nextMonthStartDate = calendar.date(byAdding: .day, value: 1, to: getLastDayOfMonth(for: date)) else {
            fatalError("Unable to calculate the next month start date for \(date)")
        }
        return nextMonthStartDate
    }

    /// Returns the calendar grid for the given date
    public func getCalendarGrid(for date: Date) -> [Date] {
        let extraDaysFromPreviousMonth = getExtraDaysFromPreviousMonth(for: date)
        let nextMonthStartDate = getNextMonthStartDate(for: date)

        let calendarGrid = (0 ..< 42).map { dayOffset -> Date in
            if dayOffset < extraDaysFromPreviousMonth {
                return calendar.date(byAdding: .day, value: -extraDaysFromPreviousMonth + dayOffset, to: getFirstDayOfMonth(for: date))!
            } else if dayOffset - extraDaysFromPreviousMonth < calendar.range(of: .day, in: .month, for: date)!.count {
                return calendar.date(byAdding: .day, value: dayOffset - extraDaysFromPreviousMonth, to: getFirstDayOfMonth(for: date))!
            } else {
                return calendar.date(byAdding: .day, value: dayOffset - extraDaysFromPreviousMonth - calendar.range(of: .day, in: .month, for: date)!.count, to: nextMonthStartDate)!
            }
        }

        return calendarGrid
    }
}
