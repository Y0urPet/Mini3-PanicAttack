//
//  BreathingExerciseView.swift
//  Mini3-PanicAttack
//
//  Created by tandyys on 21/08/24.
//

import SwiftUI

struct BreathingExerciseView: View {
    @StateObject var cycleCountManager = CycleCountManager()
    
    var body: some View {
        ZStack {
            if(cycleCountManager.isCycleFinished) {
                CongratulationView()
            } else {
                BreathingSessionView(manager: cycleCountManager)
            }
        }.navigationBarBackButtonHidden(true)
    }
}

#Preview {
    BreathingExerciseView()
}
