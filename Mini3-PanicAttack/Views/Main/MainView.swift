//
//  MainView.swift
//  Mini3-PanicAttack
//
//  Created by Timothy Andrian on 19/08/24.
//

import Foundation
import SwiftUI
import SwiftData

struct MainView: View {
    @Environment(ExerciseTrackerViewModel.self) private var viewModel: ExerciseTrackerViewModel
    private var minimumValidStreak = 1

    // Every exercise is not used to keep track of progress
    // Progress defaults to 0%
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
                                .foregroundStyle(.neutral500)
                            Image(.fire)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 20)
                            Text("\(viewModel.tracker?.currentStreak(min: minimumValidStreak) ?? -1)")
                            
                            // MARK: - Divider
                            Text("|")
                                .scaleEffect(y: 1.75)
                            
                            // MARK: - Freeze Streak
                            Text("Freeze Streak:")
                                .foregroundStyle(.neutral500)
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
                        WeeklyStreakView(viewModel: viewModel, validMin: minimumValidStreak)
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
                                .foregroundStyle(.neutral500)
                                .font(.system(size: 14))
                            Spacer()
                        }
                        
                        // TODO: Change default from 99 to 0 percent
                        WideCardViewWithProgress(exercise: viewModel.todaysExercise ?? Exercise(type: .breathing))
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
                                .foregroundStyle(.neutral500)
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
            .navigationBarBackButtonHidden()
        }
        .refreshable {
            viewModel.refresh()
        }
    }
}


#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: ExerciseTracker.self, configurations: config)
    let context = container.mainContext
    
    let vm = ExerciseTrackerViewModel(modelContext: context)
    
    // Load data
//    vm.loadDummyData()
    
//     Auto freeze streak
    vm.autoFreezeStreaks()
//    print("LEN: \(vm.tracker?.dailyStreaks.count)")
    
    return MainView()
        .modelContainer(container).modelContainer(container)
        .environment(vm)
}
