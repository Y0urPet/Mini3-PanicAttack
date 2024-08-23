//
//  ContentView.swift
//  Mini3-PanicAttack
//
//  Created by Timothy Andrian on 19/08/24.

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(ExerciseTrackerViewModel.self) private var viewModel: ExerciseTrackerViewModel
    
    var body: some View {
        MainView()
            .preferredColorScheme(.light)
    }
}
