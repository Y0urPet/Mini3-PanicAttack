//
//  GroundingView.swift
//  Mini3-PanicAttack
//
//  Created by Althaf Nafi Anwar on 22/08/24.
//

import Foundation
import SwiftUI

struct BreathingStartView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var started: Bool
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 24)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .foregroundStyle(.white)
                .offset(y: 225)
            
            VStack(alignment: .leading) {
                Spacer()
                HStack {
                    Image(.backButton)
                        .resizable()
                        .frame(width: 50, height: 50)
                        .padding(.trailing, 5)
                        .onTapGesture {
                            dismiss()
                        }
                    
                    Text("Deep Breathing")
                        .font(Font.custom("Rubik-SemiBold", size: 24))
                }
                .padding(.vertical, 20)
                
                HStack {
                    Spacer()
                    
                    Image(.thumbGrounding)
                        .resizable()
                        .frame(width: 350, height: 200)
                        .clipShape(.rect(cornerRadius: 16))
                    
                    Spacer()
                }
      
                HStack {
                    Text("Deep Breathing: The 4-7-8 Technique")
                        .font(Font.custom("Rubik-Medium", size: 16))
                        .foregroundStyle(.neutral800)
                    .padding(.top, 20)
                    .padding(.leading, 10)
                }
                
                
                Text("Experience the calming effects of the 4-7-8 breathing technique, designed to reduce stress and anxiety. Inhale through your nose for 4 seconds, hold for 7 seconds, and exhale slowly through your mouth for 8 seconds. ")
                    .font(Font.custom("Rubik-Regular", size: 16))
                    .foregroundStyle(.neutral500)
                    .padding(.vertical, 15)
                    .padding(.leading, 10)
                
                
                Text("This simple exercise helps calm your nervous system and improve focus. Follow the guided steps to incorporate this technique into your routine.")
                    .font(Font.custom("Rubik-Regular", size: 16))
                    .foregroundStyle(.neutral500)
                    .padding(.leading, 10)
                
                Spacer()
                HStack {
                    Spacer()
                        Button(action: {
                            print("Started session")
                            started = true
                            
                        }, label: {
                            Text("Start")
                                .font(Font.custom("Rubik-SemiBold", size: 17))
                                .foregroundStyle(.white)
                                .frame(width: UIScreen.main.bounds.width - 50, height: 48)
                                .background(.primary600)
                                .clipShape(.rect(cornerRadius: 53))
                        })
                        .padding(.bottom, 32)
//                    }
                    
                    Spacer()
                }
                Spacer()
            }
            .padding(.horizontal)
            .navigationBarBackButtonHidden(true)
        }
        .background(.neutral100)
    }
}

//#Preview {
//    BreathingStartView()
//}

