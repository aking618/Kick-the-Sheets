//
//  HomeViewModel.swift
//  Kick the Sheets
//
//  Created by Ayren King on 2/7/23.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var viewDidLoad: Bool = false
    
    @Binding var days: [Day]
    @Published var dateSelected: Date = Date()
    
    // broken
    init(days: Binding<[Day]>) {
        _days = days
    }
    
    func getStreakCount() -> Int {
        guard !days.isEmpty else { return 0 }
        
        var sortedDays = days.sorted(by: { $0.id < $1.id })
        var day = sortedDays.popLast()!
        
        if !day.date.isSameDay(comparingTo: Date()) || !day.date.isSameDay(comparingTo: Calendar.current.date(byAdding: .day, value: -1, to: Date())!) {
            return 0
        }
        
        var streak = day.status ? 1 : 0;
        while (sortedDays.last != nil) {
            if sortedDays.last!.status {
                streak += 1
            } else {
                break
            }
            _ = sortedDays.popLast()
        }
        
        return streak;
    }
    
    func refreshDays() {
        days = TodoDataStore.shared.getAllDays()
    }
    
    func viewDidLoad(completion: @escaping () -> Void) {
        guard !viewDidLoad else { return }
        
        viewDidLoad = true
        completion()
    }
}

