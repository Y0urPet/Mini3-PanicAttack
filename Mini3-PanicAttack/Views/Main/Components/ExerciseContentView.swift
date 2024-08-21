//
//  ExerciseContentView.swift
//  Mini3-PanicAttack
//
//  Created by Althaf Nafi Anwar on 21/08/24.
//

import SwiftUI


struct ExerciseContentView: View {
    @Environment(ExerciseTrackerViewModel.self) private var viewModel
    @Environment(\.dismiss) private var dismiss
    
    let exercise: Exercise
    
    var body: some View {
        VStack {
            Text(exercise.type.title) // Display the title of the exercise
                .font(.title)
                .padding()

            // Check if this exercise is today's exercise
            if viewModel.isTodaysExercise(of: exercise.type) {
                Text("This is today's exercise!")
                    .font(.subheadline)
                    .foregroundColor(.green)
                    .padding(.top, 5)
                Button("Mark as completed", action: {
                    viewModel.markCurrentExerciseAsComplete()
                    dismiss()
                })
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
    }
}

// MARK: - Helpers

extension Date {
    func isSameDay(as otherDate: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(self, inSameDayAs: otherDate)
    }
}

// Helper struct to hold day information
struct DayInfo: Hashable {
    let date: Date
    
    var abbreviated: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE" // Abbreviated day name
        return formatter.string(from: date).uppercased()
    }
}
