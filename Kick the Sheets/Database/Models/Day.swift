//
//  Day.swift
//  Database
//
//  Created by Ayren King on 1/26/23.
//

import Foundation

public struct Day: Hashable {
    public let id: Int64
    public let date: Date
    public let status: Bool
}

extension Day {
    static func isDayComplete(_ todos: [Todo]) -> Bool {
        guard !todos.isEmpty else { return false }
        
        return todos.reduce(true) { (result, todo) in
            result && todo.status
        }
    }
}

