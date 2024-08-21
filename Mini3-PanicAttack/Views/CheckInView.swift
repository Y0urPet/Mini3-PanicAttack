//
//  CheckInView.swift
//  Mini3-PanicAttack
//
//  Created by Timothy Andrian on 19/08/24.
//

import Foundation
import SwiftUI
import SwiftData

struct CheckInView: View {
    @Environment(ExerciseTrackerViewModel.self) private var viewModel: ExerciseTrackerViewModel
    
    var allExercisesList: [Exercise] = [
        Exercise(type: .breathing),
        Exercise(type: .grounding),
        Exercise(type: .HALT),
        Exercise(type: .PMR),
        Exercise(type: .thinking),
        Exercise(type: .visualizing),
    ]
    
    // TODO: Fix colors
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 36) {
                    VStack(spacing: 12) {
                        Text("Your Streaks")
                            .font(.system(size: 24))
                            .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        HStack {
                            
                            // MARK: - Streak count
                            Text("Count:")
                                .foregroundStyle(.gray)
                            Image(.fire)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 20)
                            Text("\(viewModel.tracker?.currentStreak ?? -1) / \(viewModel.tracker?.longestStreak ?? -1)")
                            
                            // MARK: - Divider
                            Text("|")
                                .scaleEffect(y: 1.75)
                            
                            // MARK: - Freeze Streak
                            Text("Freeze Streak:")
                                .foregroundStyle(.gray)
                            Image(.blueFire)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 20)
                            Text("\(viewModel.tracker?.freezeStreakCount ?? -1) ")
                        }
                        .font(.system(size: 14))
                        .fontWeight(.regular)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        
                        // MARK: - Streak calendar comp.
                        WeeklyStreakView(viewModel: viewModel)
                            .padding(.top, 8)
                    }
                    
                    // MARK: - Today' Practice
                    VStack(spacing: 4) {
                        HStack {
                            Text("Today’s Practice")
                                .font(.system(size: 24))
                                .fontWeight(.bold)
                            Spacer()
                        }
                        HStack {
                            Text("Complete this practice to build your streak")
                                .foregroundStyle(.gray)
                                .font(.system(size: 14))
                            Spacer()
                        }
                        
                        // TODO: Change default from 99 to 0 percent
                        HighlightedExerciseCardView(exercise: viewModel.todaysExercise ?? Exercise(type: .breathing))
                            .padding(.top, 16)
                    }
                    
                    
                    
                    // MARK: - All Practices
                    VStack(spacing: 4) {
                        HStack {
                            Text("All Practices")
                                .font(.system(size: 24))
                                .fontWeight(.bold)
                            Spacer()
                        }
                        HStack {
                            Text("Do these steps to prepare for emergencies")
                                .foregroundStyle(.gray)
                                .font(.system(size: 14))
                            Spacer()
                        }
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 0) {
                                ForEach(allExercisesList, id: \.self) { e in
                                    Spacer(minLength: 18)
                                    ExerciseCardView(exercise: e)
                                }
                            }
                        }
                        .padding(.horizontal, -18)
                        .padding(.top, 16)
                    }
                }
                .padding(18)
                .padding(.top, 20)
            }
            .background(.neutral100)
            .navigationTitle("Practice")
            .navigationBarTitleDisplayMode(.large)
            .toolbarBackground(
                Color.white,
                for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
}

struct WeeklyStreakView: View {
    @State var viewModel: ExerciseTrackerViewModel
    
    var body: some View {
           HStack(spacing: 16) {
               ForEach(daysOfWeek(), id: \.self) { day in
                   VStack {
                       Text(day.abbreviated)
                           .font(.system(size: 13))
                           .fontWeight(.bold)
                           .foregroundStyle(Calendar.current.isDateInToday(day.date) ? .blue : .gray)
                           .padding(.bottom, 4)
                       
                       // Determine the image resource based on exercise and freeze streak
                       if viewModel.tracker?.daysExercised.contains(where: { $0.isSameDay(as: day.date) }) ?? false {
                           Image(.fire)
                               .resizable()
                               .aspectRatio(contentMode: .fit)
                               .frame(width: 32)
                       } else if viewModel.tracker?.freezeStreakDays.contains(where: { $0.isSameDay(as: day.date) }) ?? false {
                           Image(.blueFire)
                               .resizable()
                               .aspectRatio(contentMode: .fit)
                               .frame(width: 32)
                       } else {
                           Image(.fireSkeleton)
                               .resizable()
                               .aspectRatio(contentMode: .fit)
                               .frame(width: 32)
                       }
                   }
               }
           }
           .padding(.top, 20)
           .padding(.bottom, 20)
           .padding(.horizontal)
           .frame(maxWidth: .infinity)
           .background(Color(.white).clipShape(RoundedRectangle(cornerRadius: 12)))
       }
       
       // Function to get the days of the current week
       private func daysOfWeek() -> [DayInfo] {
           let calendar = Calendar.current
           let today = Date()
           
           // Find the last Sunday
           let startOfWeek = calendar.date(byAdding: .day, value: -calendar.component(.weekday, from: today) + 1, to: today)!
           
           // Create an array of DayInfo for the week
           return (0..<7).map { index in
               let dayDate = calendar.date(byAdding: .day, value: index, to: startOfWeek)!
               return DayInfo(date: dayDate)
           }
       }
}

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


struct HighlightedExerciseCardView: View {
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
        NavigationLink(destination: ExerciseContentView(exercise: exercise)) {
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
                            .foregroundStyle(.gray)
                    }
                    Spacer()
                    
                    Image(imageThumb)
                        .resizable()
                        .aspectRatio(contentMode: .fill) // Fill the frame
                        .clipShape(.rect(cornerRadius: 8))
                        .frame(width: UIScreen.main.bounds.width/3)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                
                // Progress Bar
                HStack(alignment: .lastTextBaseline, spacing: 12) {
                    ProgressView(value: Float(progress), total: 100)
                    .scaleEffect(y: 1.5) // Sets ProgressView height
                    
                    Text("\(progress)%")
                        .font(.system(size: 10))
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
        NavigationLink(destination: ExerciseContentView(exercise: exercise)) {
            VStack(spacing: 4) {
                // Fixed frame for the image
                Image(imageThumb)
                    .resizable()
                    .aspectRatio(contentMode: .fill) // Fill the frame while maintaining aspect ratio
                    .frame(width: 200, height: 125) // Fixed width and height for all cards
                    .clipped() // Clips the image to fit within the specified frame
                
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(title)
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .foregroundStyle(.black)
                        Text(subTitle)
                            .font(.system(size: 14))
                            .foregroundStyle(.gray)
                    }
                    .multilineTextAlignment(.leading)
                    Spacer()
                }
                .padding()
            }
            .frame(width: 200, height: 275) // Fixed width for the entire card
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
}

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

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: ExerciseTracker.self, configurations: config)
    let context = container.mainContext
    
    let vm = ExerciseTrackerViewModel(modelContext: context)
    
    vm.loadDummyData()
    print(vm.tracker?.freezeStreakCount ?? -1)
    vm.fillFreezeStreakGaps()
    
//    tracker.load()

    return CheckInView()
        .modelContainer(container).modelContainer(container)
        .environment(vm)
    
}
