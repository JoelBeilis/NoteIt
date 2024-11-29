//
//  StickIt.swift
//  StickIt
//
//  Created by Joel Beilis on 2024-11-29.
//

import WidgetKit
import SwiftUI
import SwiftData
import AppIntents

// MARK: - Timeline Provider
struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) {
        var entries: [SimpleEntry] = []
        let entryDate = Date()
        let entry = SimpleEntry(date: .now)
        entries.append(entry)

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

// MARK: - Simple Entry
struct SimpleEntry: TimelineEntry {
    let date: Date
}

// MARK: - Widget View
struct StickItEntryView: View {
    var entry: Provider.Entry
    @Query(todoDescriptor, animation: .snappy) private var activeList: [Todo]
    
    var body: some View {
        VStack {
            ForEach(activeList) { todo in
                HStack(spacing: 10) {
                    Button(intent: ToggleButton(id: todo.taskID)) {
                        Image(systemName: todo.isCompleted ? "checkmark.circle.fill" : "circle")
                            .font(.callout)
                            .tint(todo.priority.color.gradient)
                            .buttonBorderShape(.circle)
                    }

                    Text(todo.task)
                        .font(.callout)
                        .lineLimit(1)
                        .strikethrough(todo.isCompleted)

                    Spacer(minLength: 0)
                }
                .transition(.push(from: .bottom))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .overlay {
            if activeList.isEmpty {
                Text("No Tasks")
                    .font(.callout)
                    .transition(.push(from: .bottom))
            }
        }
    }
    
    static var todoDescriptor: FetchDescriptor<Todo> {
        let predicate = #Predicate<Todo> { !$0.isCompleted }
        let sort = [SortDescriptor(\Todo.lastUpdated, order: .reverse)]

        var descriptor = FetchDescriptor(predicate: predicate, sortBy: sort)
        descriptor.fetchLimit = 3
        return descriptor
    }
}

// MARK: - Widget Configuration
struct StickIt: Widget {
    let kind: String = "Todo List"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            StickItEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
                .modelContainer(for: Todo.self)
        }
        .configurationDisplayName("Tasks")
        .description("This is a Todo List")
    }
}

// MARK: - App Intent for Interactivity
fileprivate struct ToggleButton: AppIntent {
    static var title: LocalizedStringResource = .init(stringLiteral: "Toggle Todo State")
    
    @Parameter(title: "Todo ID")
    var id: String
    
    init() {}
    init(id: String) { self.id = id }
    
    func perform() async throws -> some IntentResult {
        // Access the ModelContext
        let context = ModelContext(try ModelContainer(for: Todo.self))

        // Fetch the Todo item by ID
        let descriptor = FetchDescriptor(predicate: #Predicate<Todo> { $0.taskID == id })
        if let todo = try await context.fetch(descriptor).first {
            // Toggle the completion state
            todo.isCompleted.toggle()
            todo.lastUpdated = Date()

            // Save the updated context
            try await context.save()
        }

        return .result()
    }
}
