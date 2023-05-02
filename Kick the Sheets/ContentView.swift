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
        TabView(selection: $selectedTab) {
            DayView(dayId: viewModel.currentDayId)
                .tag(Tab.home)
            Home(viewModel: HomeViewModel(days: $viewModel.days))
                .tag(Tab.calendar)
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .padding(.bottom)
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
            Divider()
            bottomNavBar
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

