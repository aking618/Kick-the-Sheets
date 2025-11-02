//
//  Months.swift
//  Kick the Sheets
//
//  Created by Ayren King on 9/1/23.
//

public enum MonthPosition {
    case previous
    case current
    case next
}

public enum Months: Int, CustomStringConvertible, Identifiable, CaseIterable {
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

    public var id: Int {
        hashValue
    }

    public var description: String {
        switch self {
        case .january:
            "January"
        case .february:
            "February"
        case .march:
            "March"
        case .april:
            "April"
        case .may:
            "May"
        case .june:
            "June"
        case .july:
            "July"
        case .august:
            "August"
        case .september:
            "September"
        case .october:
            "October"
        case .november:
            "November"
        case .december:
            "December"
        }
    }
}
