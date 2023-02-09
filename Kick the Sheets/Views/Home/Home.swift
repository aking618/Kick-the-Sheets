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
     
    @StateObject private var viewModel = HomeViewModel(demo: true)
    
    var body: some View {
        BaseView {
            VStack(alignment: .center) {
                Text("Kick the Sheets")
                    .ktcFont(.title)
                    .foregroundColor(KTSColors.textColor.color)
                    .padding()
                
                Image(systemName: "bed.double")
                    .resizable()
                    .foregroundColor(KTSColors.textColor.color)
                    .frame(width: 48, height: 48)
                    .padding(.bottom)
                
                SelectableCalendarView(
                    monthToDisplay: Date(),
                    dateSelected: $viewModel.dateSelected,
                    dateBackgroundBuilder: nil,
                    dateForgroundBuilder: {date in
                        // TODO: Change to NavLink to show previous days
                        AnyView(Text("\(date.calendarDay)"))
                    }
                ){ date in date.getCompletionColor(viewModel.days) }
                    .foregroundColor(KTSColors.textColor.color)
                    .padding(.bottom)
                
                RoundedButton(viewModel.buttonText, action: handleButtonTap)
                
                Spacer()
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
    }
}
