//
//  WideCardViewWithProgress.swift
//  Mini3-PanicAttack
//
//  Created by Althaf Nafi Anwar on 21/08/24.
//

import SwiftUI

struct WideCardViewWithProgress: View {
    var exercise: Exercise
    var title: String
    var subTitle: String
    var imageThumb: ImageResource
    var progress: Int
    
    init(exercise: Exercise) {
        self.exercise = exercise
        self.title = exercise.type.title
        self.subTitle = exercise.type.description
        self.imageThumb = exercise.type.imageThumb
        self.progress = exercise.progress
    }
    
    var body: some View {
        NavigationLink(destination: exercise.type.exerciseView) {
            VStack {
                HStack(spacing: 2) {
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Text(title)
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .foregroundStyle(.black)
                        Text(subTitle)
                            .font(.system(size: 14))
                            .fontWeight(.regular)
                            .foregroundStyle(.neutral400)
                    }
                    .multilineTextAlignment(.leading)
                    .padding(.trailing, 10)
                    .padding(.leading, 5)
                    .padding(.top, 8)
                    
                    Spacer()
                    
                    Image(imageThumb)
                        .resizable()
                        .aspectRatio(contentMode: .fill) // Fill the frame
                        .clipShape(.rect(cornerRadius: 8))
                        .frame(width: UIScreen.main.bounds.width/3)
                    Spacer()
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                
                // Progress Bar
                HStack(alignment: .lastTextBaseline, spacing: 12) {
                    ProgressView(value: Float(progress), total: 100)
                    .scaleEffect(y: 1.75) // Sets ProgressView height
                    .tint(.primary500)
                    
                    Text("\(progress)%")
                        .font(.system(size: 10))
                        .foregroundStyle(.neutral900)
                
                }
                .padding(.horizontal)
                .padding(.bottom, 16)
            }
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 12))
        .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    WideCardViewWithProgress(exercise: Exercise(type: .HALT))
}

