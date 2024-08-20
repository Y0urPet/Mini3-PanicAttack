//
//  TimerComponentViewExtension.swift
//  Mini3-PanicAttack
//
//  Created by tandyys on 20/08/24.
//

import Foundation

extension BreathingSessionView {
    public func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            time += 1
        }
    }
    
    public func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}
