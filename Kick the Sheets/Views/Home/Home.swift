//
//  Home.swift
//  Kick the Sheets
//
//  Created by Ayren King on 12/16/22.
//

import SelectableCalendarView
import SwiftUI

struct Home: View {
    @EnvironmentObject private var launchScreenState: LaunchScreenStateManager
     
    @StateObject var viewModel: HomeViewModel
    
    @ViewBuilder
    private var header: some View {
        Text("Kick the Sheets")
            .ktsFont(.title2)
            .foregroundColor(KTSColors.textColor.color)
            .padding()
    }
    
    @ViewBuilder
    private var calendar: some View {
        CalendarWrapperView(
            days: $viewModel.days,
            selectedDate: $viewModel.dateSelected
        )
    }
    
    @ViewBuilder
    private var footer: some View {
        Text("🔥 \(viewModel.getStreakCount()) Day Streak")
            .foregroundColor(KTSColors.textColor.color)
            .padding(.bottom, 16)
        
        Spacer()
        
        VStack(spacing: 0) {
            Text(viewModel.dateSelected.getDayString())
                .frame(maxWidth: .infinity, alignment: .leading)
            Rectangle()
                .frame(height: 1)
        }
        .padding(.bottom)
        
        CircularProgressView(
            progress: viewModel.completedCountForSelectedDate,
            total: viewModel.totalCountForSelectedDate,
            15
        )
    }
    
    var body: some View {
        BaseView {
            ScrollView {
                VStack(alignment: .center) {
                    header
                    calendar
                    footer
                }
            }
        }
        .refreshable {
            viewModel.refreshDays()
            
            print(viewModel.dateSelected)
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 13 Mini")
    }
}
