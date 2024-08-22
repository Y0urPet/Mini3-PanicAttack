//
//  GroundingView.swift
//  Mini3-PanicAttack
//
//  Created by Althaf Nafi Anwar on 22/08/24.
//

import Foundation
import SwiftUI

struct GroundingStartView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var started: Bool
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 24)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .foregroundStyle(.white)
                .offset(y: 225)
            
            VStack(alignment: .leading) {
                HStack {
                    Image(.backButton)
                        .resizable()
                        .frame(width: 50, height: 50)
                        .padding(.trailing, 5)
                        .onTapGesture {
                            dismiss()
                        }
                    
                    Text("Grounding")
                        .font(Font.custom("Rubik-SemiBold", size: 24))
                }
                .padding(.vertical, 30)
                
                HStack {
                    Spacer()
                    
                    Image(.thumbGrounding)
                        .resizable()
                        .frame(width: 350, height: 200)
                        .clipShape(.rect(cornerRadius: 16))
                    
                    Spacer()
                }
      
                HStack {
                    Text("Grounding: The 5-4-3-2-1 Technique")
                        .font(Font.custom("Rubik-Medium", size: 16))
                        .foregroundStyle(.neutral800)
                    .padding(.top, 20)
                    .padding(.leading, 10)
                }
                
                
                Text("The 5-4-3-2-1 grounding technique helps you manage anxiety by focusing on your senses. Notice 5 things you see, 4 you can touch, 3 you hear, 2 you smell, and 1 you taste. ")
                    .font(Font.custom("Rubik-Regular", size: 16))
                    .foregroundStyle(.neutral500)
                    .padding(.vertical, 15)
                    .padding(.leading, 10)
                
                
                Text("This simple exercise brings you back to the present moment, helping you regain control and calm your mind. Follow the steps to practice grounding whenever you need to refocus.")
                    .font(Font.custom("Rubik-Regular", size: 16))
                    .foregroundStyle(.neutral500)
                    .padding(.leading, 10)
                
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
                .padding(.top, 32)
                
            }
            .padding(.horizontal)
            .navigationBarBackButtonHidden(true)
        }
        .background(.neutral100)
    }
}

