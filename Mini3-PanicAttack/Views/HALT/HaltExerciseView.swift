//
//  HaltExerciseView.swift
//  Mini3-PanicAttack
//
//  Created by Althaf Nafi Anwar on 23/08/24.
//

//
//  GroundingExerciseView.swift
//  Mini3-PanicAttack
//
//  Created by Althaf Nafi Anwar on 22/08/24.
//

import Foundation
import SwiftUI


struct HaltExerciseView: View {
   
    @Environment(ExerciseTrackerViewModel.self) private var viewModel
    @StateObject var cycleCountManager = CycleCountManager()
    @State var started: Bool = false
    @State var startContent: StartViewContent
    @State var sessionContent: [SessionContent]
    
    var body: some View {
        ZStack {
            // Introduction
            if !started {
                GenericStartView(started: $started, content: startContent)
            
            // Loop through all the exercises/session contents
            } else if (!cycleCountManager.isCycleFinished) {
                GenericSessionView(manager: cycleCountManager, content: sessionContent)
            
            // If session/exercise is finished show CongratsView
            } else {
                CongratulationView(exerciseType: .HALT, exerciseTitle: "HALT")
                    .onAppear {
                        if viewModel.isTodaysExercise(of: .HALT) {
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
    

    init() {
        self.startContent = StartViewContent(title: "H.A.L.T", subTitle: "The H.A.L.T Exercise", firstParagraph: "The H.A.L.T. technique is a mindful approach to managing your emotions by tuning into your basic needs. When you feel overwhelmed, take a moment to ask yourself if you’re Hungry, Angry, Lonely, or Tired.", secondParagraph: "By regularly practicing the H.A.L.T. technique, you can build a habit of self-awareness and self-care. It’s a simple check-in that can make a big difference in maintaining your emotional well-being.")
        
        self.sessionContent = [
            SessionContent(title: "Nourish Your Body", subTitle: "Feeling hungry? Eat something satisfying to fuel yourself. Even something small can make a big difference.", image: .halt1),
            SessionContent(title: "Acknowledge Your Emotions", subTitle: "Feeling angry or frustrated? Take a deep breath and let it be. It’s okay, let it pass!", image: .halt1),
            SessionContent(title: "Connect with Someone", subTitle: "Feeling lonely? Reach out to a friend, family member, or even spend some time with pet.", image: .halt1),
            SessionContent(title: "Rest and Recharge", subTitle: "Feeling tired? Take a moment to rest or close your eyes to recharge.", image: .halt1),
        ]
        
    }
}

#Preview {
    HaltExerciseView()
}


