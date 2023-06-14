////
////  ContentView.swift
////  Kick the Sheets
////
////  Created by Ayren King on 1/26/23.
////

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()

    @ViewBuilder
    private var tabView: some View {
        switch viewModel.selectedTab {
        case .home:
            DayView()
                .tag(Tab.home)
                .transition(.leadingSlide)
        case .calendar:
            Home(viewModel: HomeViewModel(days: $viewModel.days))
                .tag(Tab.calendar)
                .transition(viewModel.calendarTransition)
        case .settings:
            SettingsView()
                .tag(Tab.settings)
                .transition(.backslide)
        }
    }

    @ViewBuilder private var bottomNavBar: some View {
        BottomNavigationBar(selectedTab: $viewModel.selectedTab, transition: $viewModel.calendarTransition)
            .background(AnimatedIndicator(selectedTab: $viewModel.selectedTab))
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
        .environmentObject(viewModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()

        ContentView()
            .environment(\.colorScheme, .dark)
    }
}
