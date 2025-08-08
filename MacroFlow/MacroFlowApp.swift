//
//  MacroFlowApp.swift
//  MacroFlow
//
//  Created by Tristan Norbury on 8/8/2025.
//

import SwiftUI
import SwiftData

@main
struct MacroFlowApp: App {
    // Shared ModelContainer for the app
    var sharedModelContainer: ModelContainer = {
        // Register all your model types here
        let schema = Schema([
            Trip.self,
            // Add other models here if any
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
                .modelContainer(sharedModelContainer) // Attach the container here
        }
    }
}
