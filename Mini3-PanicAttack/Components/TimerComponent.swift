//
//  TimerComponent.swift
//  Mini3-PanicAttack
//
//  Created by tandyys on 20/08/24.
//

import SwiftUI

struct TimerComponent: View {
    @State var elapsedTime: Int
    @State var timer: Timer?
    
    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .frame(width: 113, height: 48)
            .foregroundStyle(Color.init(hex: 0xD6DCF1))
            .overlay {
                //Dummy time
                Text("00:0\(elapsedTime)")
                    .font(Font.custom("Rubik-SemiBold", size: 17))
                    .foregroundStyle(Color.init(hex: 0x3350B8))
            }
    }
}
