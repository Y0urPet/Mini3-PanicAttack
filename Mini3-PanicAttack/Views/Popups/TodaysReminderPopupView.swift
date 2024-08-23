//
//  TodaysReminderPopupView.swift
//  Mini3-PanicAttack
//
//  Created by Althaf Nafi Anwar on 23/08/24.
//

import MijickPopupView
import SwiftUI
import Foundation

struct TodaysReminderPopupView: CentrePopup {
    
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
            Text("Do today’s practice to get your streaks!")
                .font(Font.custom("Rubik-SemiBold", size: 24))
                .foregroundStyle(.black)
                .padding(.bottom, 1)
                .multilineTextAlignment(.center)
//            Text("You are still halfway done!")
//                .font(Font.custom("Rubik-Regular", size: 16))
//                .foregroundStyle(.neutral500)
            HStack {
                Button {
                    dismiss()
                    triggerToHome = true
                } label: {
                    HStack {
                        Spacer()
                        Text("Continue")
                            .font(Font.custom("Rubik-SemiBold", size: 17))
                            .foregroundStyle(.white)
                            .frame(width: UIScreen.main.bounds.width - 50, height: 48)
                            .background(.primary600)
                            .clipShape(.rect(cornerRadius: 53))
                            .multilineTextAlignment(.center)
                        Spacer()
                    }
                }
                .padding(3)
                .padding(.top, 10)
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


