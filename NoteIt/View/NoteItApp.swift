//
//  NoteItApp.swift
//  NoteIt
//
//  Created by Joel Beilis on 2024-11-28.
//

import SwiftUI

@main
struct NoteItApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Todo.self)
    }
}
