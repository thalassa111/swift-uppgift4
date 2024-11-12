//
//  swift_uppgift4App.swift
//  swift-uppgift4
//
//  Created by Dennis on 2024-11-12.
//

import SwiftUI
import SwiftData

@main
struct swift_uppgift4App: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            TodoItem.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
