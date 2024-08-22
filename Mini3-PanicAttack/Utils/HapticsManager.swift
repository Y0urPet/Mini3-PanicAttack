//
//  HapticsManager.swift
//  Mini3-PanicAttack
//
//  Created by tandyys on 21/08/24.
//

import Foundation
import Buzz

struct Drone: HapticSequence {
    var haptics: HapticEvents {
        for i in 0..<11 {
            let intensity = (Float(i) / 11) * 0.5
            Continuous(duration: 0.3,
                       intensity: intensity,
                       sharpness: Float(i) / 18)
        }
        
        for i in (0..<11).reversed() {
            let intensity = (Float(i) / 11) * 0.5
            Continuous(duration: 0.3,
                       intensity: intensity,
                       sharpness: Float(i) / 22)
        }
        
        for i in 0..<11 {
            let intensity = (Float(i) / 11) * 0.5
            Continuous(duration: 0.3,
                       intensity: intensity,
                       sharpness: Float(i) / 18)
        }
        
        for i in (0..<11).reversed() {
            let intensity = (Float(i) / 11) * 0.5
            Continuous(duration: 0.4,
                       intensity: intensity,
                       sharpness: Float(i) / 22)
        }
        
        for i in 0..<11 {
            let intensity = (Float(i) / 11) * 0.5
            Continuous(duration: 0.3,
                       intensity: intensity,
                       sharpness: Float(i) / 18)
        }
        
        for i in (0..<11).reversed() {
            let intensity = (Float(i) / 11) * 0.5
            Continuous(duration: 0.4,
                       intensity: intensity,
                       sharpness: Float(i) / 22)
        }
        
        for i in 0..<11 {
            let intensity = (Float(i) / 11) * 0.5
            Continuous(duration: 0.3,
                       intensity: intensity,
                       sharpness: Float(i) / 18)
        }
        
        for i in (0..<11).reversed() {
            let intensity = (Float(i) / 11) * 0.5
            Continuous(duration: 0.3,
                       intensity: intensity,
                       sharpness: Float(i) / 22)
        }
        
        for i in 0..<11 {
            let intensity = (Float(i) / 11) * 0.5
            Continuous(duration: 0.3,
                       intensity: intensity,
                       sharpness: Float(i) / 18)
        }
        
        for i in (0..<11).reversed() {
            let intensity = (Float(i) / 11) * 0.5
            Continuous(duration: 0.4,
                       intensity: intensity,
                       sharpness: Float(i) / 22)
        }
        
        for i in 0..<11 {
            let intensity = (Float(i) / 11) * 0.5
            Continuous(duration: 0.3,
                       intensity: intensity,
                       sharpness: Float(i) / 18)
        }
        
        for i in (0..<11).reversed() {
            let intensity = (Float(i) / 11) * 0.5
            Continuous(duration: 0.4,
                       intensity: intensity,
                       sharpness: Float(i) / 22)
        }
        
        for i in 0..<11 {
            let intensity = (Float(i) / 11) * 0.5
            Continuous(duration: 0.3,
                       intensity: intensity,
                       sharpness: Float(i) / 18)
        }
        
        for i in (0..<11).reversed() {
            let intensity = (Float(i) / 11) * 0.5
            Continuous(duration: 0.3,
                       intensity: intensity,
                       sharpness: Float(i) / 22)
        }
        
        for i in 0..<11 {
            let intensity = (Float(i) / 11) * 0.5
            Continuous(duration: 0.3,
                       intensity: intensity,
                       sharpness: Float(i) / 18)
        }
        
        for i in (0..<11).reversed() {
            let intensity = (Float(i) / 11) * 0.5
            Continuous(duration: 0.4,
                       intensity: intensity,
                       sharpness: Float(i) / 22)
        }
        
        for i in 0..<11 {
            let intensity = (Float(i) / 11) * 0.5
            Continuous(duration: 0.3,
                       intensity: intensity,
                       sharpness: Float(i) / 18)
        }
        
        for i in (0..<11).reversed() {
            let intensity = (Float(i) / 11) * 0.5
            Continuous(duration: 0.4,
                       intensity: intensity,
                       sharpness: Float(i) / 22)
        }
        
        for i in 0..<11 {
            let intensity = (Float(i) / 11) * 0.5
            Continuous(duration: 0.3,
                       intensity: intensity,
                       sharpness: Float(i) / 18)
        }
        
        for i in (0..<11).reversed() {
            let intensity = (Float(i) / 11) * 0.5
            Continuous(duration: 0.3,
                       intensity: intensity,
                       sharpness: Float(i) / 22)
        }
        
        for i in 0..<11 {
            let intensity = (Float(i) / 11) * 0.5
            Continuous(duration: 0.3,
                       intensity: intensity,
                       sharpness: Float(i) / 18)
        }
        
        for i in (0..<11).reversed() {
            let intensity = (Float(i) / 11) * 0.5
            Continuous(duration: 0.4,
                       intensity: intensity,
                       sharpness: Float(i) / 22)
        }
        
        for i in 0..<11 {
            let intensity = (Float(i) / 11) * 0.5
            Continuous(duration: 0.3,
                       intensity: intensity,
                       sharpness: Float(i) / 18)
        }
        
        for i in (0..<11).reversed() {
            let intensity = (Float(i) / 11) * 0.5
            Continuous(duration: 0.4,
                       intensity: intensity,
                       sharpness: Float(i) / 22)
        }
    }
}
