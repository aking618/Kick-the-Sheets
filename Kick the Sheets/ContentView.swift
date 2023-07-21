////
////  ContentView.swift
////  Kick the Sheets
////
////  Created by Ayren King on 1/26/23.
////

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appState: AppState

    @ViewBuilder
    private var tabView: some View {
        switch appState.selectedTab {
        case .home:
            DayView()
                .tag(Tab.home)
                .transition(.leadingSlide)
        case .calendar:
            Home(viewModel: HomeViewModel(todoService: appState.todoService, days: $appState.days))
                .tag(Tab.calendar)
                .transition(appState.calendarTransition)
        case .settings:
            SettingsView()
                .tag(Tab.settings)
                .transition(.backslide)
        }
    }

    @ViewBuilder private var bottomNavBar: some View {
        BottomNavigationBar()
            .background(AnimatedIndicator(selectedTab: $appState.selectedTab))
            .padding(.horizontal)
    }

    var body: some View {
        VStack(spacing: 0) {
            tabView
                .padding(.bottom)
                .background(KTSColors.background.color)
            Divider()
            bottomNavBar
        }
        .ignoresSafeArea(.keyboard)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()

        ContentView()
            .environment(\.colorScheme, .dark)
    }
}
