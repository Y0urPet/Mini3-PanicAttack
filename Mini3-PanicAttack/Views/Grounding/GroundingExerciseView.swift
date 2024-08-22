//
//  GroundingExerciseView.swift
//  Mini3-PanicAttack
//
//  Created by Althaf Nafi Anwar on 22/08/24.
//

import Foundation
import SwiftUI


struct GroundingExerciseView: View {
   
    @Environment(ExerciseTrackerViewModel.self) private var viewModel
    @StateObject var cycleCountManager = CycleCountManager()
    @State var started: Bool = false
    
    var body: some View {
        ZStack {
            // Introduction
            if !started {
                GroundingStartView(started: $started)
            
            // Loop through all the exercises/session contents
            } else if (!cycleCountManager.isCycleFinished) {
                GroundingSessionView(manager: cycleCountManager)
            
            // If session/exercise is finished show CongratsView
            } else {
                CongratulationView(exerciseTitle: "Grounding")
                    .onAppear {
                        if viewModel.isTodaysExercise(of: .grounding) {
                            viewModel.markTodaysAsCompleted()
                        }
                    }
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            print(started, cycleCountManager.isCycleFinished)
        }
    }
}

#Preview {
    GroundingExerciseView()
}
