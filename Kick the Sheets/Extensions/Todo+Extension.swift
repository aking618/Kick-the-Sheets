//
//  Todo+Extension.swift
//  Kick the Sheets
//
//  Created by Ayren King on 1/26/23.
//

import Foundation

extension Todo {
    static func completedCount(from list: [Todo]) -> Int {
        list.filter { $0.status }.count
    }
}
