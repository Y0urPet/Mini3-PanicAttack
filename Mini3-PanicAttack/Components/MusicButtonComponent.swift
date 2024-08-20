//
//  MusicButtonComponent.swift
//  Mini3-PanicAttack
//
//  Created by tandyys on 20/08/24.
//

import SwiftUI

struct MusicButtonComponent: View {
    var body: some View {
        Circle()
            .foregroundStyle(Color.init(hex: 0xD6DCF1))
            .frame(width: 46)
            .overlay {
                Image("musicButton")
            }
    }
}

#Preview {
    MusicButtonComponent()
}
