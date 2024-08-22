//
//  BreathingAnimationComponentExtension.swift
//  Mini3-PanicAttack
//
//  Created by tandyys on 20/08/24.
//

import Foundation
import SwiftUI

extension BreathingAnimationComponent {
    func startAnimationSequence() {
                // INHALE YOUR BREATH for 4 second
                withAnimation(Animation.linear(duration: totalDuration + 2)) {
                    thirdBackground = 0
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    withAnimation(Animation.linear(duration: totalDuration)) {
                        secondBackgroundOpacity = 0
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                    withAnimation(Animation.linear(duration: totalDuration)) {
                        firstBackgroundOpacity = 0
                    }
                }
                
                // HOLD YOUR BREATH for 7 second
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    withAnimation(Animation.linear(duration: 0.5).repeatForever()) {
                        scaling = 0.9
                    }
                }
                
                // EXHALE YOUR BREATH for 8 second
                DispatchQueue.main.asyncAfter(deadline: .now() + 12) {
                    withAnimation(Animation.linear(duration: totalDuration)) {
                        firstBackgroundOpacity = 1
                        scaling = 1
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 15) {
                    withAnimation(Animation.linear(duration: totalDuration)) {
                        secondBackgroundOpacity = 1
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 18) {
                    withAnimation(Animation.linear(duration: totalDuration)) {
                        thirdBackground = 1
                    }
                }
            }
}
