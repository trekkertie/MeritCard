//
//  MeritCardApp.swift
//  MeritCard
//
//  Created by Jonathan Preston on 07/08/2024.
//

import SwiftUI
import SwiftData

@main
struct MeritCardApp: App {
    var container: ModelContainer
    init() {
        do {
            let config = ModelConfiguration(for: MeritCard.self, MeritLogFile.self, MeritIcon.self) //isStoredInMemoryOnly: true)

            container = try ModelContainer(for: MeritCard.self, MeritLogFile.self, MeritIcon.self, configurations: config)
        } catch {
            fatalError("Failed to configure SwiftData container.")
        }
    }

    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        //.modelContainer(for: [MeritCard.self, MeritLogFile.self], inMemory: true)
        .modelContainer(appContainer)
    }
}
