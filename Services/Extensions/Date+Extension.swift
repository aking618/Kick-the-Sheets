//
//  Date+Extension.swift
//  Kick the Sheets
//
//  Created by Ayren King on 12/22/22.
//

import Foundation
import SwiftUI

public extension Date {
    var key: Int {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        return Int(formatter.string(from: self)) ?? 0
    }
}
