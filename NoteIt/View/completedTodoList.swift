//
//  completedTodoList.swift
//  NoteIt
//
//  Created by Joel Beilis on 2024-11-28.
//

import SwiftUI
import SwiftData

struct CompletedTodoList: View {
    @Query private var completedList: [Todo]

    init() {
        let predicate = #Predicate<Todo> { $0.isCompleted }
        let sort = [SortDescriptor(\Todo.lastUpdated, order: .reverse)]

        var descriptor = FetchDescriptor(predicate: predicate, sortBy: sort)
        if !showAll {
            // Limiting to 15
            descriptor.fetchLimit = 15
        }
        _completedList = Query(descriptor, animation: .snappy)
    }

    // View Properties
    @State private var showAll: Bool = false

    var body: some View {
        Section {
            // List content here
        } header: {
            HStack {
                Text("Completed")
                Spacer(minLength: 0)
                if showAll {
                    Button("Show Recents") {
                        showAll = false
                    }
                }
            }
            .font(.caption)
        } footer: {
            if completedList.count == 15 && !showAll {
                HStack {
                    Text("Showing Recent 15 Tasks")
                        .foregroundStyle(.gray)
                    Spacer(minLength: 0)
                    Button("Show All") {
                        showAll = true
                    }
                }
                .font(.caption)
            }
        }
    }
}

#Preview {
    ContentView()
}
