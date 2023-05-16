//
//  AnimatedIndicator.swift
//  Kick the Sheets
//
//  Created by Ayren King on 4/2/23.
//

import SwiftUI

struct AnimatedIndicator: View {
    @Binding var selectedTab: Tab

    var body: some View {
        GeometryReader { proxy in
            let width = proxy.size.width / CGFloat(Tab.allCases.count)
            let x = width * CGFloat(selectedTab.rawValue)
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.blue)
                .frame(width: width - 20, height: 5)
                .offset(x: x + 10, y: -2.5)
                .animation(.spring(), value: selectedTab)
        }
    }
}
