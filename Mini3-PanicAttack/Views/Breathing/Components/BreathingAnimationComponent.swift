//
//  BreathingAnimationComponent.swift
//  Mini3-PanicAttack
//
//  Created by tandyys on 20/08/24.
//

import SwiftUI

struct BreathingAnimationComponent: View {
    @State var thirdBackground = 1.0
    @State var secondBackgroundOpacity = 1.0
    @State var firstBackgroundOpacity = 1.0
    
    @State var scaling = 1.0
    let totalDuration: Double = 1.0
    
    @State var breathState = "Inhale"
    @State var currentBreathingType: BreathingType = .inhale
    @State var durationAnimation: TimeInterval = 4
    @State var breathStateCycleCount: Int = 1
    
    @ObservedObject var manager: CycleCountManager
    
    var body: some View {
        ZStack {
            //The biggest
            Image("CloudThree")
                .opacity(thirdBackground)
            
            Image("CloudTwo")
                .opacity(secondBackgroundOpacity)
            
            //The smallest
            Image("CloudOne")
                .opacity(firstBackgroundOpacity)
            
            Circle()
                .frame(width: 182)
                .foregroundStyle(Color.init(hex: 0x3350B8))
                .overlay {
                    Text("\(breathState)")
                        .font(Font.custom("Rubik-Semibold", size: 24))
                        .foregroundStyle(.white)
                }
                .scaleEffect(scaling)
        }
        .onAppear {
            startAnimationSequence()
            changeBreathState()
        }
    }
    
    func changeBreathState() {
        switch currentBreathingType {
        case .inhale:
            Timer.scheduledTimer(withTimeInterval: durationAnimation, repeats: false) { _ in
                currentBreathingType = .hold
                durationAnimation = 7 // Duration for hold phase
                breathState = "Hold"
                if(breathStateCycleCount == 12) {
                    manager.isCycleFinished = true
                }
                else {
                    breathStateCycleCount+=1
                }
                changeBreathState()
            }
        case .hold:
            Timer.scheduledTimer(withTimeInterval: durationAnimation, repeats: false) { _ in
                currentBreathingType = .exhale
                durationAnimation = 8 // Duration for exhale phase
                breathState = "Exhale"
                if(breathStateCycleCount == 12) {
                    manager.isCycleFinished = true
                }
                else {
                    breathStateCycleCount+=1
                }
                changeBreathState()
            }
        case .exhale:
            Timer.scheduledTimer(withTimeInterval: durationAnimation, repeats: false) { _ in
                currentBreathingType = .inhale
                durationAnimation = 4 // Duration for inhale phase
                breathState = "Inhale"
                if(breathStateCycleCount == 12) {
                    manager.isCycleFinished = true
                }
                else {
                    breathStateCycleCount+=1
                }
                changeBreathState()
            }
        }
    }
}
