//
//  ContentView.swift
//  NoteIt
//
//  Created by Joel Beilis on 2024-11-28.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            Home()
                .navigationTitle("NoteIt")
        }
    }
}

#Preview {
    ContentView()
}
