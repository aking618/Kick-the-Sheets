//
//  Home.swift
//  Kick the Sheets
//
//  Created by Ayren King on 12/16/22.
//

import SelectableCalendarView
import SwiftUI

struct Home: View {
    @Binding var path: NavigationPath
     
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        BaseView {
            ScrollView{
                VStack(alignment: .center) {
                    Text("Kick the Sheets")
                        .ktcFont(.title2)
                        .foregroundColor(KTSColors.textColor.color)
                        .padding()
                    
                    Image(systemName: "bed.double")
                        .resizable()
                        .foregroundColor(KTSColors.textColor.color)
                        .frame(width: 36, height: 36)
                        .padding(.bottom)
                    
                    SelectableCalendarView(
                        monthToDisplay: Date(),
                        dateSelected: $viewModel.dateSelected,
                        dateBackgroundBuilder: { date in
                            AnyView(
                                Circle()
                                    .foregroundColor(date.backgroundColor(viewModel.days))
                                    .frame(width: 35, height: 35)
                                 )
                        },
                        dateForgroundBuilder: {date in
                            // TODO: Change to NavLink to show previous days
                            AnyView(
                                Text("\(date.calendarDay)")
                                    .foregroundColor(date.foregroundColor(viewModel.days))
                            )
                        }
                    ){ date in date.backgroundColor(viewModel.days) }
                        .foregroundColor(KTSColors.textColor.color)
                        .padding(.bottom)
                        .ktcFont(.body)
                    
                    RoundedButton(viewModel.buttonText, action: handleButtonTap)
                    
                    Text("🔥 \(viewModel.getStreakCount()) Day Streak")
                        .padding(.bottom)
                    
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
                    Spacer()
                }
            }
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
