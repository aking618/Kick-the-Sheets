//
//  DbTodo.swift
//  Database
//
//  Created by Ayren King on 1/26/23.
//

import SQLite

struct DbTodo {
    let table = Table("todos")
    let id = Expression<Int64>("id")
    let dayId = Expression<Int64>("dayId")
    let status = Expression<Bool>("status")
    let description = Expression<String>("description")
}
