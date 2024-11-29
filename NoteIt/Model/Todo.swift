//
//  Todo.swift
//  NoteIt
//
//  Created by Joel Beilis on 2024-11-28.
//

import SwiftUI
import SwiftData

@Model
class Todo {
    private(set) var taskID: String = UUID().uuidString
    var task: String
    var isCompleted: Bool = false
}
