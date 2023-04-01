////
////  ContentView.swift
////  Kick the Sheets
////
////  Created by Ayren King on 1/26/23.
////

import SwiftUI

struct ContentView: View {
    @State private var selectedTab: Tab = Tab.home
    
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $selectedTab) {
                DayView(dayId: 0)
                    .tag(Tab.home)
                Home()
                    .tag(Tab.calendar)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .padding(.bottom)
            Divider()
            HStack(spacing: 0) {
                ForEach(Tab.allCases, id: \.self) { tab in
                    Button(action: {
                        withAnimation {
                            selectedTab = tab
                        }
                    }) {
                        Spacer()
                        Image(systemName: tab.iconName)
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(selectedTab == tab ? .blue : .gray)
                            .padding(.vertical, 10)
                        Spacer()
                    }
                    .background(Color.clear)
                }
            }
            .background(GeometryReader { proxy in
                let width = proxy.size.width / CGFloat(Tab.allCases.count)
                let x = width * CGFloat(selectedTab.rawValue)
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.blue)
                    .frame(width: width - 20, height: 5)
                    .offset(x: x + 10, y: -2.5)
                    .animation(.spring(), value: selectedTab)
            })
            .padding(.horizontal)
            .onChange(of: selectedTab) { tab in
                guard Tab.allCases.contains(tab) else { return }
                print("Selected tab: \(tab)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

