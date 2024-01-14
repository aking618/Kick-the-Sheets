//
//  Tab.swift
//  Kick the Sheets
//
//  Created by Ayren King on 3/31/23.
//

enum Tab: Int, CaseIterable {
    case home
    case calendar
    case settings

    var title: String {
        switch self {
        case .home:
            "My Tasks"
        case .calendar:
            "Calendar"
        case .settings:
            "Settings"
        }
    }

    var iconName: String {
        switch self {
        case .home:
            "list.bullet"
        case .calendar:
            "calendar"
        case .settings:
            "gearshape"
        }
    }

    var accessiblityID: String {
        switch self {
        case .home:
            "todoView"
        case .calendar:
            "homeView"
        case .settings:
            "settingsView"
        }
    }
}
