//
//  AppState.swift
//  Kick the Sheets
//
//  Created by Ayren King on 7/19/23.
//

import SwiftUI

class AppState: ObservableObject {
    @Published var selectedTab: Tab = .home
    @Published var currentDayId: Int64 = 0
    @Published var todosForToday: [Todo] = []
    @Published var days: [Day] = []

    @Published var calendarTransition: AnyTransition = .backslide
}
