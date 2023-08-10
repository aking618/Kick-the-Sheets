//
//  ContentView.swift
//  Kick the Sheets
//
//  Created by Ayren King on 1/26/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        VStack(spacing: 0) {
            tabView
                .padding(.bottom)
                .background(KTSColors.background.color)
            Divider()
            bottomNavBar
        }
        .ignoresSafeArea(.keyboard)
        .onAppear {
            appState.showMigrationPopup = appState.shouldShowMigrationPopup()
            appState.updateLastPopupDate()
        }
        .alert("Migrate Unfinished Todos", isPresented: $appState.showMigrationPopup) {
            Button("Migrate") {
                appState.handleTodoMigration()
            }
            Button("Cancel", role: .cancel) {}
        }
    }
}

// MARK: - Views

extension ContentView {
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

    private var bottomNavBar: some View {
        BottomNavigationBar()
            .background(AnimatedIndicator(selectedTab: $appState.selectedTab))
            .padding(.horizontal)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AppState())
    }
}
