//
//  PlayButtonComponent.swift
//  Mini3-PanicAttack
//
//  Created by tandyys on 20/08/24.
//

import SwiftUI

struct PauseButtonComponent: View {
    var body: some View {
        Circle()
            .foregroundStyle(Color.init(hex: 0xD6DCF1))
            .frame(width: 70)
            .overlay {
                Image("pauseButton")
            }
    }
}

#Preview {
    PauseButtonComponent()
}
