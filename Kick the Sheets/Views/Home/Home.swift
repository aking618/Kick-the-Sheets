//
//  Home.swift
//  Kick the Sheets
//
//  Created by Ayren King on 12/16/22.
//

import SelectableCalendarView
import SwiftUI

struct Home: View {
    @StateObject var viewModel: HomeViewModel

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
        }
    }
}

// MARK: - Views

extension Home {
    private var header: some View {
        Text("Kicking the Sheets")
            .ktsFont(.title2)
            .foregroundColor(KTSColors.text.color)
            .padding()
    }

    private var calendar: some View {
        CalendarWrapperView(
            days: $viewModel.days,
            selectedDate: $viewModel.dateSelected
        )
    }

    private var footer: some View {
        VStack(spacing: 0) {
            Text("🔥 \(viewModel.getStreakCount()) Day Streak")
                .foregroundColor(KTSColors.text.color)
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
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home(viewModel: HomeViewModel(todoService: GeneralTodoService(), days: .constant([:])))
            .environmentObject(AppState())
            .previewDevice("iPhone 13 Mini")
    }
}
