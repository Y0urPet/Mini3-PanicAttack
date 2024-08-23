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
        let total = 1.0
        // Cycle 1
        // INHALE YOUR BREATH for 4 second
        withAnimation(Animation.linear(duration: 4 + 2)) {
            print("Cycle 1")
            thirdBackground = 0
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            withAnimation(Animation.linear(duration: total)) {
                secondBackgroundOpacity = 0
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            withAnimation(Animation.linear(duration: total)) {
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
            withAnimation(Animation.linear(duration: total)) {
                firstBackgroundOpacity = 1
                scaling = 1
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 15) {
            withAnimation(Animation.linear(duration: total)) {
                secondBackgroundOpacity = 1
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 18) {
            withAnimation(Animation.linear(duration: total)) {
                thirdBackground = 1
            }
        }

        // Cycle 2
        withAnimation(Animation.linear(duration: total + 18)) {
            print("Cycle 2")
            thirdBackground = 0.1
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 20.5) {
            withAnimation(Animation.linear(duration: total)) {
                secondBackgroundOpacity = 0.1
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 22) {
            withAnimation(Animation.linear(duration: total)) {
                firstBackgroundOpacity = 0.1
            }
        }
        
        // HOLD YOUR BREATH for 7 second
        DispatchQueue.main.asyncAfter(deadline: .now() + 24) {
            withAnimation(Animation.linear(duration: 0.5).repeatForever()) {
                scaling = 0.9
            }
        }
        
        // EXHALE YOUR BREATH for 8 second
        DispatchQueue.main.asyncAfter(deadline: .now() + 31) {
            withAnimation(Animation.linear(duration: total)) {
                firstBackgroundOpacity = 1
                scaling = 1
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 35) {
            withAnimation(Animation.linear(duration: total)) {
                secondBackgroundOpacity = 1
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 36) {
            withAnimation(Animation.linear(duration: total)) {
                thirdBackground = 1
            }
        }
        // Cycle 3
        withAnimation(Animation.linear(duration: total + 36)) {
            print("Cycle 3")
            thirdBackground = 0.1
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 40.5) {
            withAnimation(Animation.linear(duration: total)) {
                secondBackgroundOpacity = 0.1
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 37) {
            withAnimation(Animation.linear(duration: total)) {
                firstBackgroundOpacity = 0.1
            }
        }
        
        // HOLD YOUR BREATH for 7 second
        DispatchQueue.main.asyncAfter(deadline: .now() + 44) {
            withAnimation(Animation.linear(duration: 0.5).repeatForever()) {
                scaling = 0.9
            }
        }
        
        // EXHALE YOUR BREATH for 8 second
        DispatchQueue.main.asyncAfter(deadline: .now() + 51) {
            withAnimation(Animation.linear(duration: total)) {
                firstBackgroundOpacity = 1
                scaling = 1
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 54) {
            withAnimation(Animation.linear(duration: total)) {
                secondBackgroundOpacity = 1
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 57) {
            withAnimation(Animation.linear(duration: total)) {
                thirdBackground = 1
            }
        }
        // Cycle 4
        withAnimation(Animation.linear(duration: total + 57)) {
            print("Cycle 4")
            thirdBackground = 0.1
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 57.5) {
            withAnimation(Animation.linear(duration: total)) {
                secondBackgroundOpacity = 0.1
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 61) {
            withAnimation(Animation.linear(duration: total)) {
                firstBackgroundOpacity = 0.1
            }
        }
        
        // HOLD YOUR BREATH for 7 second
        DispatchQueue.main.asyncAfter(deadline: .now() + 61) {
            withAnimation(Animation.linear(duration: 0.5).repeatForever()) {
                scaling = 0.9
            }
        }
        
        // EXHALE YOUR BREATH for 8 second
        DispatchQueue.main.asyncAfter(deadline: .now() + 62) {
            withAnimation(Animation.linear(duration: total)) {
                firstBackgroundOpacity = 1
                scaling = 1
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 65) {
            withAnimation(Animation.linear(duration: total)) {
                secondBackgroundOpacity = 1
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 67) {
            withAnimation(Animation.linear(duration: total)) {
                thirdBackground = 1
            }
        }
    }
}
