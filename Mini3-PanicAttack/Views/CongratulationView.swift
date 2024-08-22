//
//  CongratulationView.swift
//  Mini3-PanicAttack
//
//  Created by tandyys on 21/08/24.
//

import SwiftUI

struct CongratulationView: View {
    
    var exerciseTitle: String
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                Image(uiImage: UIImage(named: "congratsAsset")!)
                    .padding(44)
                Text("Congratulations!")
                    .foregroundStyle(.black)
                    .font(Font.custom("Rubik-Medium", size: 20))
                    .padding(2)
                Text("You have finished this exercise! Continue to the next Exercise?")
                    .font(Font.custom("Rubik-Regular", size: 16))
                    .foregroundStyle(.neutral500)
                    .padding(2)
                    .multilineTextAlignment(.center)
                Button(action: {
                    print("dismissed congrats view")
                    dismiss()
                }, label: {
                    Text("Next Practice")
                        .font(Font.custom("Rubik-SemiBold", size: 17))
                        .foregroundStyle(.white)
                        .frame(width: 360, height: 48)
                        .background(.primary600)
                        .clipShape(.rect(cornerRadius: 53))
                })
                .padding(16)
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.neutral100)
            .padding(.vertical)
            .padding(.horizontal, 20)
        }
        .padding()
        .background(.neutral100)
    }
}

#Preview {
    CongratulationView(exerciseTitle: "Preview Exercise")
}
