//
//  ExitPopup.swift
//  Mini3-PanicAttack
//
//  Created by Althaf Nafi Anwar on 23/08/24.
//
import MijickPopupView
import SwiftUI
import Foundation

struct ExitPopupView: CentrePopup {
    
    @Environment(\.dismiss) private var rootDismiss
    @Binding var triggerToHome: Bool
    
    func createContent() -> some View {
        VStack {
            Image(.confused)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width / 2.4)
                .clipShape(Circle())
                .padding()
            Text("End this session?")
                .font(Font.custom("Rubik-SemiBold", size: 24))
                .foregroundStyle(.black)
                .padding(.bottom, 1)
            Text("You are still halfway done!")
                .font(Font.custom("Rubik-Regular", size: 16))
                .foregroundStyle(.neutral500)
            HStack {
                Button {
                    dismiss()
                    triggerToHome = true
                } label: {
                    Text("End")
                        .font(Font.custom("Rubik-SemiBold", size: 17))
                        .foregroundStyle(.primary600)
                        .frame(width: 127, height: 48)
                        .background(RoundedRectangle(
                            cornerRadius: 53,
                            style: .continuous
                        )
                            .stroke(.primary600, lineWidth: 2))
                        .clipShape(.rect(cornerRadius: 53))
                }
                .padding(2)
                Button {
                    dismiss()
                } label: {
                    Text("Continue")
                        .font(Font.custom("Rubik-SemiBold", size: 17))
                        .foregroundStyle(.white)
                        .frame(width: 127, height: 48)
                        .background(.primary600)
                        .clipShape(.rect(cornerRadius: 53))
                }
                .padding(3)
            }
            .padding()
        }
        .padding(.top, 50)
        .padding(.bottom, 25)
    }
    func configurePopup(popup: BottomPopupConfig) -> BottomPopupConfig {
        popup
            .horizontalPadding(10)
            .bottomPadding(42)
            .cornerRadius(16)
    }
}

//#Preview {
//    ExitPopupView().createContent()
//}

