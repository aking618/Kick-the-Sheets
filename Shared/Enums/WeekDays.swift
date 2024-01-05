//
//  WeekDays.swift
//  Kick the Sheets
//
//  Created by Ayren King on 9/1/23.
//

public enum WeekDays: String, Identifiable, CaseIterable {
    case sunday = "Sun"
    case monday = "Mon"
    case tuesday = "Tue"
    case wednesday = "Wed"
    case thursday = "Thu"
    case friday = "Fri"
    case saturday = "Sat"

    public var id: Int {
        hashValue
    }
}
