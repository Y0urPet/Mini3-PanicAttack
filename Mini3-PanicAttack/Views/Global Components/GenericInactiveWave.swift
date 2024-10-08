//
//  GenericBreathingWave.swift
//  Mini3-PanicAttack
//
//  Created by Althaf Nafi Anwar on 22/08/24.
//

import SwiftUI

struct GenericInactiveWaveWithImage: View {
    @State var thirdBackground = 1.0
    @State var secondBackgroundOpacity = 1.0
    @State var firstBackgroundOpacity = 1.0
    
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
    }
}

#Preview {
    GenericInactiveWaveWithImage()
}
