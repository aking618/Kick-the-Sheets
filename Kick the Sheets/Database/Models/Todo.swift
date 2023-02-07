//
//  Todo.swift
//  Database
//
//  Created by Ayren King on 1/26/23.
//

import Foundation

public struct Todo: Hashable {
    public let id: Int64
    public let dayId: Int64
    public var description: String
    public var status: Bool
}


