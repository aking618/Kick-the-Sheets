//
//  Tab.swift
//  Kick the Sheets
//
//  Created by Ayren King on 3/31/23.
//

enum Tab: Int, CaseIterable {
    case home
    case calendar
    
    var title: String {
        switch self {
            case .home:
                return "My Tasks"
            case .calendar:
                return "Calendar"
        }
    }
    
    var iconName: String {
        switch self {
            case .home:
                return "list.bullet"
            case .calendar:
                return "calendar"
        }
    }
}
