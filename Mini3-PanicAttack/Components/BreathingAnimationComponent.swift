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
                    Text("Breath")
                        .font(Font.custom("Rubik-Semibold", size: 24))
                        .foregroundStyle(.white)
                }
        }
        .onAppear {
            startAnimationSequence()
        }
    }
}

#Preview {
    BreathingAnimationComponent()
}
