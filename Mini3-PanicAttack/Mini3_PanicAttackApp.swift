//
//  Mini3_PanicAttackApp.swift
//  Mini3-PanicAttack
//
//  Created by Timothy Andrian on 19/08/24.
//

import SwiftUI
import SwiftData

@main
struct Mini3_PanicAttackApp: App {
    
    let container: ModelContainer
    let viewModel: ExerciseTrackerViewModel
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(container)
        .environment(viewModel)
    }
    
    init() {
        do {
            // TODO: Change to store persistently
            let config = ModelConfiguration(isStoredInMemoryOnly: false)
            container = try ModelContainer(for: ExerciseTracker.self, configurations: config)
            viewModel = ExerciseTrackerViewModel(modelContext: container.mainContext)
        } catch {
            fatalError("Failed to create ModelContainer")
        }
    }
}
