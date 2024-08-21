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
                changeBreathState()
            }
        case .hold:
            Timer.scheduledTimer(withTimeInterval: durationAnimation, repeats: false) { _ in
                currentBreathingType = .exhale
                durationAnimation = 8 // Duration for exhale phase
                breathState = "Exhale"
                changeBreathState()
            }
        case .exhale:
            Timer.scheduledTimer(withTimeInterval: durationAnimation, repeats: false) { _ in
                currentBreathingType = .inhale
                durationAnimation = 4 // Duration for inhale phase
                breathState = "Inhale"
                changeBreathState()
            }
        }
    }
}
