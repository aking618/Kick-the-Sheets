//
//  Todo+Extension.swift
//  Kick the Sheets
//
//  Created by Ayren King on 1/26/23.
//

import Foundation

public extension Todo {
    internal static let demoList: [Todo] = Array(repeating: .init(id: 0, dayId: 0, description: "Test Description of item", status: false), count: 3)

    static func completedCount(from list: [Todo]) -> Int {
        list.filter(\.status).count
    }

    static func filterIndexListByStatus(_ list: [Todo], target: Bool) -> [Int] {
        list.enumerated().compactMap { index, todo in
            todo.status == target ? index : nil
        }
    }
}
