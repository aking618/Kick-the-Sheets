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

class CalendarHelper {
    let calendar = Calendar.current

    /// Returns the first day of the month for the given date
    func getFirstDayOfMonth(for date: Date) -> Date {
        guard let firstDayOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: date)) else {
            fatalError("Unable to calculate the first day of the month for \(date)")
        }
        return firstDayOfMonth
    }

    /// Returns the last day of the month for the given date
    func getLastDayOfMonth(for date: Date) -> Date {
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
    func getCalendarGrid(for date: Date) -> [Date] {
        let extraDaysFromPreviousMonth = getExtraDaysFromPreviousMonth(for: date)
        let extraDaysFromNextMonth = getExtraDaysFromNextMonth(for: date)
        let previousMonthEndDate = getPreviousMonthEndDate(for: date)
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

struct CalendarGridView: View {
    @Binding var selectedDate: Date
    @Binding var currentMonth: Date

    private let calendarGridHelper = CalendarHelper()

    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(), count: 7), content: {
            ForEach(CalendarMonth.WeekDays.allCases, id: \.id) {
                Text($0.rawValue)
                    .padding(.top, 1)
                    .lineLimit(1)
            }

            ForEach(calendarGridHelper.getCalendarGrid(for: currentMonth), id: \.self) { date in
                let monthPosition = date.getMonthPosition(relativeTo: currentMonth)
                CalendarDayView(date: date, monthPosition: monthPosition, selectedDate: $selectedDate)
            }
        })
    }
}

struct CalendarDayView: View {
    let date: Date
    let monthPosition: CalendarMonth.MonthPosition // this is in reference to what month is being displayed
    @Binding var selectedDate: Date

    var foregroundColor: Color {
        guard monthPosition == .current else {
            return .gray
        }

        return date.isSameDay(as: selectedDate) ? .white : .black
    }

    var backgroundColor: Color {
        return date.isSameDay(as: selectedDate) ? .blue : .clear
    }

    var body: some View {
        Text("\(date.dateNumber)")
            .foregroundColor(foregroundColor)
            .background(backgroundColor)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .onTapGesture {
                selectedDate = date
            }
    }
}

extension Date {
    func isSameDay(as date: Date) -> Bool {
        return Calendar.current.isDate(self, inSameDayAs: date)
    }

    var dateNumber: Int {
        return Calendar.current.component(.day, from: self)
    }

    var month: CalendarMonth.Months {
        return CalendarMonth.Months(rawValue: Calendar.current.component(.month, from: self) - 1)!
    }

    var year: Int {
        return Calendar.current.component(.year, from: self)
    }

    func getMonthPosition(relativeTo date: Date) -> CalendarMonth.MonthPosition {
        if self < CalendarHelper().getFirstDayOfMonth(for: date) {
            return .previous
        } else if self > CalendarHelper().getLastDayOfMonth(for: date) {
            return .next
        } else {
            return .current
        }
    }
}

enum CalendarMonth {
    enum Months: Int, CustomStringConvertible, Identifiable, CaseIterable {
        case january
        case february
        case march
        case april
        case may
        case june
        case july
        case august
        case september
        case october
        case november
        case december

        var id: Int {
            hashValue
        }

        var description: String {
            switch self {
            case .january:
                return "January"
            case .february:
                return "February"
            case .march:
                return "March"
            case .april:
                return "April"
            case .may:
                return "May"
            case .june:
                return "June"
            case .july:
                return "July"
            case .august:
                return "August"
            case .september:
                return "September"
            case .october:
                return "October"
            case .november:
                return "November"
            case .december:
                return "December"
            }
        }
    }

    enum WeekDays: String, Identifiable, CaseIterable {
        case sunday = "Sun"
        case monday = "Mon"
        case tuesday = "Tue"
        case wednesday = "Wed"
        case thursday = "Thu"
        case friday = "Fri"
        case saturday = "Sat"

        var id: Int {
            hashValue
        }
    }

    enum MonthPosition {
        case previous
        case current
        case next
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView(selectedDate: .constant(Date()))
    }
}
