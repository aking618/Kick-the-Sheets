//
//  Date+Extension.swift
//  Kick the Sheets
//
//  Created by Ayren King on 12/22/22.
//

import Foundation
import SwiftUI

extension Date {
    func getCompletionColor(_ days: [Day]) -> Color {
        if self.isSameDay(comparingTo: Date()) {
           return KTSColors.textColor.color
        }
       
        if self > Date() {
           return KTSColors.darkPurple.color
        }

        if let day = days.first(where: { $0.date.isSameDay(comparingTo: self) }) {
            return day.status ? KTSColors.green.color : KTSColors.red.color
        }
        
        return KTSColors.darkPurple.color
    }
    
    var calendarDay: Int {
        Calendar.current.dateComponents([.day], from: self).day ?? 0
    }
}
