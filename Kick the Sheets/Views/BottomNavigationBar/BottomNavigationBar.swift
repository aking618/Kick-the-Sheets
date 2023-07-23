//
//  BottomNavigationBar.swift
//  Kick the Sheets
//
//  Created by Ayren King on 4/2/23.
//

import SwiftUI

struct BottomNavigationBar: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        HStack(spacing: 0) {
            ForEach(Tab.allCases, id: \.self) { tab in
                Button(action: {
                    if appState.selectedTab == .calendar, tab == .settings {
                        appState.calendarTransition = .leadingSlide
                    } else if appState.selectedTab == .settings, tab == .calendar {
                        appState.calendarTransition = .leadingSlide
                    } else { appState.calendarTransition = .backslide }

                    withAnimation {
                        appState.selectedTab = tab
                    }
                }) {
                    Spacer()
                    Image(systemName: tab.iconName)
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(appState.selectedTab == tab ? .blue : .gray)
                        .padding(.vertical, 10)
                    Spacer()
                }
            }
        }
    }
}
