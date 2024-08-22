//
//  ExerciseCardView.swift
//  Mini3-PanicAttack
//
//  Created by Althaf Nafi Anwar on 21/08/24.
//

import SwiftUI


struct ExerciseCardView: View {
    var exercise: Exercise
    let title: String
    let subTitle: String
    let imageThumb: ImageResource
    
    init(exercise: Exercise) {
        self.exercise = exercise
        self.title = exercise.type.title
        self.subTitle = exercise.type.description
        self.imageThumb = exercise.type.imageThumb
    }
    
    var body: some View {
        NavigationLink(destination: BreathingExerciseView()/*ExerciseContentView(exercise: exercise)*/) {
            VStack(spacing: 4) {
                // Fixed frame for the image
                Image(imageThumb)
                    .resizable()
                    .aspectRatio(contentMode: .fill) // Fill the frame while maintaining aspect ratio
                    .frame(width: 200, height: 130) // Fixed width and height for all cards
                    .clipped() // Clips the image to fit within the specified frame
                
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(title)
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .foregroundStyle(.black)
                        Text(subTitle)
                            .font(.system(size: 14))
                            .foregroundStyle(.neutral400)
                    }
                    .multilineTextAlignment(.leading)
                    Spacer()
                }
                .padding()
            }
            .frame(width: 200, height: 235) // Fixed width for the entire card
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
}

#Preview {
    ExerciseCardView(exercise: Exercise(type: .HALT))
}
