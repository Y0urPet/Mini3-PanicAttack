//
//  CongratulationView.swift
//  Mini3-PanicAttack
//
//  Created by tandyys on 21/08/24.
//

import SwiftUI

struct CongratulationView: View {
    
    
    @Environment(ExerciseTrackerViewModel.self) private var viewModel
    
    var exerciseType: ExerciseType
    var exerciseTitle: String
    
    @State private var triggerToHome = false
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                Image(uiImage: UIImage(named: "congratsAsset")!)
                    .padding(32)
                Text("Congratulations!")
                    .foregroundStyle(.black)
                    .font(Font.custom("Rubik-Medium", size: 20))
                    .padding(2)
                Text("You have finished this exercise! Continue to the next exercise?")
                    .font(Font.custom("Rubik-Regular", size: 16))
                    .foregroundStyle(.neutral500)
                    .padding(2)
                    .padding(.horizontal, 30)
                    .multilineTextAlignment(.center)
                Button(action: {
                    print("dismissed congrats view")
                    
                    if (viewModel.todaysExercise?.progress ?? 0 < 100),
                       !viewModel.isTodaysExercise(of: exerciseType) {
                        TodaysReminderPopupView(triggerToHome: $triggerToHome).showAndStack()
                    }
                    
                    dismiss()
                }, label: {
                    Text("Next Practice")
                        .font(Font.custom("Rubik-SemiBold", size: 17))
                        .foregroundStyle(.white)
                        .frame(width: 360, height: 48)
                        .background(.primary600)
                        .clipShape(.rect(cornerRadius: 53))
                })
                .onChange(of: triggerToHome, initial: true) {
                    if triggerToHome {
                        triggerToHome.toggle()
                        dismiss()
                    }
                }
                .padding(16)
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.neutral100)
            .padding(.vertical)
            .padding(.horizontal, 30)
        }
        .padding()
        .background(.neutral100)
    }
}
//
//#Preview {
//    CongratulationView(exerciseTitle: "Preview Exercise", exerciseType: .grounding)
//}
