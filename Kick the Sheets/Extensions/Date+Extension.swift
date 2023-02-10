//
//  Date+Extension.swift
//  Kick the Sheets
//
//  Created by Ayren King on 12/22/22.
//

import Foundation
import SwiftUI

extension Date {
    func backgroundColor(_ days: [Day]) -> Color {
        if self.isSameDay(comparingTo: Date()) {
           return KTSColors.saffron.color
        }
       
        if self > Date() {
            return KTSColors.gray.color
        }

        if let day = days.first(where: { $0.date.isSameDay(comparingTo: self) }) {
            return day.status ? KTSColors.persianGreen.color : KTSColors.burntSienna.color
        }
        
        return KTSColors.gray.color
    }
    
    func foregroundColor(_ days: [Day]) -> Color {
        if self.isSameDay(comparingTo: Date()) {
           return KTSColors.textColor.color
        }
       
        if self > Date() {
            return KTSColors.textColor.color
        }

        if days.first(where: { $0.date.isSameDay(comparingTo: self) }) != nil {
            return .white
        }
        
        return KTSColors.textColor.color
    }
    
    var calendarDay: Int {
        Calendar.current.dateComponents([.day], from: self).day ?? 0
    }
    
    func getDayString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMMM d"
        return formatter.string(from: self)
    }
}
