//
//  CongratulationView.swift
//  Mini3-PanicAttack
//
//  Created by tandyys on 21/08/24.
//

import SwiftUI

struct CongratulationView: View {
    var body: some View {
        ZStack {
            VStack {
                //Image(uiImage: UIImage(named: "x_button")!)
                    //.frame(maxWidth: .infinity, alignment: .trailing)
                Spacer()
                Image(uiImage: UIImage(named: "congratsAsset")!)
                    .padding(44)
                Text("Congratulations!")
                    .foregroundStyle(.black)
                    .font(Font.custom("Rubik-Medium", size: 20))
                    .padding(2)
                Text("You Have Finished Deep Breathing Exercise! Continue to The Next Exercise?")
                    .font(Font.custom("Rubik-Regular", size: 16))
                    .foregroundStyle(Color(red: 0.40784313725490196, green: 0.4549019607843137, blue: 0.5372549019607843))
                    .padding(2)
                Button {
                    
                } label: {
                    Text("Next Practice")
                        .font(Font.custom("Rubik-SemiBold", size: 17))
                        .foregroundStyle(.white)
                        .frame(width: 360, height: 48)
                        .background(Color(red: 0.2, green: 0.3137254901960784, blue: 0.7215686274509804))
                        .clipShape(.rect(cornerRadius: 53))
                }
                .padding(16)
                Spacer()
            }
            .ignoresSafeArea()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.white)
            .padding(16)
        }
        .background(.white)
    }
}

#Preview {
    CongratulationView()
}
