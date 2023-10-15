//
//  Months.swift
//  Kick the Sheets
//
//  Created by Ayren King on 9/1/23.
//

enum MonthPosition {
    case previous
    case current
    case next
}

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
