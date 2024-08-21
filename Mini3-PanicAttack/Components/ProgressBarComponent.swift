//
//  ProgressBarComponent.swift
//  Mini3-PanicAttack
//
//  Created by tandyys on 21/08/24.
//

import SwiftUI

struct ProgressBarComponent: View {
    @State var progressValue: CGFloat = 0
    @State var currentBreathingType: BreathingType = .inhale
    @State var durationAnimation: TimeInterval = 4

    let max: CGFloat = 311

    var body: some View {
        ZStack() {
            Rectangle()
                .frame(width: max, height: 27)
                .foregroundStyle(.gray.opacity(0.5))
                .clipShape(.rect(cornerRadius: 27))
            HStack() {
                Rectangle()
                    .frame(width: progressValue, height: 27)
                    .foregroundStyle(.blue)
                    .clipShape(.rect(cornerRadius: 50))
                    .onAppear {
                        withAnimation(Animation.linear(duration: durationAnimation)) {
                            progressValue = max
                        }
                    }
                    .onChange(of: progressValue) { value in
                        if value == max {
                            restartAnimation()
                        }
                    }
                Spacer()
            }
            .padding(.leading, 40)
        }
    }

    func restartAnimation() {
        switch currentBreathingType {
        case .inhale:
            withAnimation(Animation.linear(duration: durationAnimation)) {
                progressValue = max
            }
            Timer.scheduledTimer(withTimeInterval: durationAnimation, repeats: false) { _ in
                currentBreathingType = .hold
                durationAnimation = 7 // Duration for hold phase
                progressValue = 0 // Reset progress value
            }
        case .hold:
            withAnimation(Animation.linear(duration: durationAnimation)) {
                progressValue = max
            }
            Timer.scheduledTimer(withTimeInterval: durationAnimation, repeats: false) { _ in
                currentBreathingType = .exhale
                durationAnimation = 8 // Duration for exhale phase
                progressValue = 0 // Reset progress value
            }
        case .exhale:
            withAnimation(Animation.linear(duration: durationAnimation)) {
                progressValue = max
            }
            Timer.scheduledTimer(withTimeInterval: durationAnimation, repeats: false) { _ in
                currentBreathingType = .inhale
                durationAnimation = 4 // Duration for inhale phase
                progressValue = 0 // Reset progress value
            }
        }
    }
}

#Preview {
    ProgressBarComponent()
}
