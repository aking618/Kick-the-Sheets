////
////  ContentView.swift
////  Kick the Sheets
////
////  Created by Ayren King on 1/26/23.
////

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = ContentViewModel()
    @State var selectedTab: Tab = Tab.home
    
    @ViewBuilder
    private var tabView: some View {
        switch selectedTab {
        case .home:
            DayView(dayId: viewModel.currentDayId, todos: $viewModel.todosForToday)
                .tag(Tab.home)
                .transition(.leadingSlide)
        case .calendar:
            Home(viewModel: HomeViewModel(days: $viewModel.days))
                .tag(Tab.calendar)
                .transition(selectedTab != .settings ? .backslide : .leadingSlide)
        case .settings:
            Text("Settings Page")
                .tag(Tab.settings)
                .transition(.backslide)
        }
    }
    
    @ViewBuilder private var bottomNavBar: some View {
        BottomNavigationBar(selectedTab: $selectedTab)
        .background(AnimatedIndicator(selectedTab: $selectedTab))
        .padding(.horizontal)
        .onChange(of: selectedTab) { tab in
            guard Tab.allCases.contains(tab) else { return }
            print("Selected tab: \(tab)")
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            tabView
                .animation(.easeOut, value: selectedTab)
                .padding(.bottom)
            Divider()
            bottomNavBar
        }
        .background(.white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

