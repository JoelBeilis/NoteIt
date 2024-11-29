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
    var priority: Priority = Priority.normal
    var lastUpdated: Date = Date.now
    
    init(taskID: String, task: String, isCompleted: Bool, priority: Priority) {
        self.taskID = taskID
        self.task = task
        self.isCompleted = isCompleted
        self.priority = priority
    }
}

enum Priority: String, Codable, CaseIterable {
    case normal = "Normal"
    case medium = "Medium"
    case high = "High"
    
    var color: Color {
        switch self {
        case .normal:
            return .green
        case .medium:
            return .yellow
        case .high:
            return .red
        }
    }
    
}

