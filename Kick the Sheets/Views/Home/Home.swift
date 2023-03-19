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
    
    @Binding var path: NavigationPath
     
    @StateObject private var viewModel = HomeViewModel()
    
//    @ViewBuilder
//    private var header: some View {
//        Text("Kick the Sheets")
//            .ktcFont(.title2)
//            .foregroundColor(KTSColors.textColor.color)
//            .padding()
//    }
//    
//    @ViewBuilder
//    priv
    
    var body: some View {
        BaseView {
            ScrollView{
                VStack(alignment: .center) {
                    header
                    
                    CalendarWrapperView(
                        days: $viewModel.days,
                        selectedDate: $viewModel.dateSelected
                    )
                    
                    RoundedButton(viewModel.buttonText, action: handleButtonTap)
                    
                    Text("🔥 \(viewModel.getStreakCount()) Day Streak")
                        .padding(.bottom, 16)
                    
                    Spacer()
                    
                    VStack(spacing: 0){
                        Text(Date().getDayString())
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Rectangle()
                            .frame(height: 1)
                    }
                    .padding(.bottom)
                    
                    CircularProgressView(
                        progress: Todo.completedCount(from: viewModel.todosForToday),
                        total: viewModel.todosForToday.count,
                        15
                    )
                }
            }
        }
        .onAppear {
            viewModel.refreshDays()
        }
        .refreshable {
            viewModel.refreshDays()
        }
    }
}

// MARK: - UI Actions
extension Home {
    private func handleButtonTap() {
        viewModel.createDayIfNeeded()
        
        if let currentDayId = viewModel.currentDayId {
            path.append(currentDayId)
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 14")
        
        ContentView()
            .previewDevice("iPhone 13 Mini")
    }
}
