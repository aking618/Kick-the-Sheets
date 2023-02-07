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
     
    @State var currentDayId: Int64?
    @State var todosForToday: [Todo] = []
    @State var days: [Day] = []
    
    @State var dateSelected: Date = Date()
    
    var body: some View {
        BaseView {
            VStack(alignment: .center) {
                Text("Kick the Sheets")
                    .font(.title.bold())
                    .foregroundColor(KTSColors.textColor.color)
                    .padding()
                Image(systemName: "bed.double")
                    .resizable()
                    .foregroundColor(KTSColors.textColor.color)
                    .frame(width: 48, height: 48)
                    .padding(.bottom)
                
                SelectableCalendarView(
                    monthToDisplay: Date(),
                    dateSelected: $dateSelected,
                    dateBackgroundBuilder: nil,
                    dateForgroundBuilder: {date in
                        AnyView(Text("\(Calendar.current.component(.day, from: date))")) // TODO: Possibly change to NavLink to show previous days
                    }
                ){ date in date.getCompletionColor(days) }
                    .foregroundColor(KTSColors.textColor.color)
                    .padding(.bottom)
                
                RoundedButton(getButtonText(), action: handleButtonTap)
                
                Spacer()
            }
        }
        .onAppear(perform: handleOnAppear)
    }
}

extension Home {
    private func handleOnAppear() {
        days = TodoDataStore.shared.getAllDays()
        if let currenDay = days.first(where: { $0.date.isSameDay(comparingTo: Date()) }) {
            currentDayId = currenDay.id
            todosForToday = TodoDataStore.shared.getTodosForDayById(dayId: currenDay.id)
        }
    }
    
    private func handleButtonTap() {
        if currentDayId == nil {
            if let currentDayId = TodoDataStore.shared.insertDay() {
                self.currentDayId = currentDayId
            }
        }
        
        if let currentDayId = currentDayId {
            path.append(currentDayId)
        }
    }
    
    private func getButtonText() -> String {
        return currentDayId != nil ? "Continue your day!" : "Start your day!"
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
