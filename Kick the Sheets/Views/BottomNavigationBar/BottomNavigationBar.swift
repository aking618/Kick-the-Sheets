//
//  BottomNavigationBar.swift
//  Kick the Sheets
//
//  Created by Ayren King on 4/2/23.
//

import SwiftUI

struct BottomNavigationBar: View {
    
    @Binding var selectedTab: Tab
    
    var body: some View {
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
    }
}