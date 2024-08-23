//
//  BreathingExerciseView.swift
//  Mini3-PanicAttack
//
//  Created by tandyys on 21/08/24.
//

import SwiftUI

struct BreathingExerciseView: View {
    @Environment(ExerciseTrackerViewModel.self) private var viewModel
    @StateObject var cycleCountManager = CycleCountManager()
    @State var started: Bool = false
    
    var body: some View {
        ZStack {
            if !started {
                BreathingStartView(started: $started)
            }
            
            else if (!cycleCountManager.isCycleFinished) {
                BreathingSessionView(manager: cycleCountManager)
               
            } 
            
            
            else {
                CongratulationView(exerciseType: .breathing, exerciseTitle: "Breathing Exercise")
                    .onAppear {
                        if viewModel.isTodaysExercise(of: .breathing) {
                            viewModel.markTodaysAsCompleted()
                        }
                    }
            }
        }
        .background(.neutral100)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    BreathingExerciseView()
}
