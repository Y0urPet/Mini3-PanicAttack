//
//  ExerciseTrackerViewModel.swift
//  Mini3-PanicAttack
//
//  Created by Althaf Nafi Anwar on 20/08/24.
//
// ExerciseTrackerViewModel.swift

import SwiftData
import Foundation

@Observable
class ExerciseTrackerViewModel {
    private let repository: ExerciseTrackerRepository
    
    var modelContext: ModelContext
    var tracker: ExerciseTracker?
    var todaysExercise: Exercise?

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        
        /* Change the repository type below to use SwiftData, don't forget to change config */
        
//        self.repository = PersistentExerciseTrackerRepository(modelContext: modelContext)
        self.repository = InMemoryExerciseTrackerRepository()
        
        load()
    }
    
    func load() {
        do {
            if let tracker = try repository.fetchExerciseTracker() {
                self.tracker = tracker
//                print("Fetch successful: (\(tracker.longestStreak) streak)")
//                print("lastExercise: \(self.tracker?.lastExercise.title ?? "?")")
//                print("todaysExercise: \(self.todaysExercise?.type.title ?? "?")")
            } else {
                let singletonTracker = try repository.insertDefaultExerciseTracker()
                self.tracker = singletonTracker
            }
            
            // Set today's exercise based on last finished exercise
            self.todaysExercise = Exercise(type: tracker?.lastExercise.getNext() ?? .breathing, progress: 0)
        } catch {
            print("Fetch failed: \(error)")
        }
    }

    
    // Used for previews (randomizes data)
    func loadDummyData() {
        guard let tracker = self.tracker else { return }
        
        let calendar = Calendar.current
        let today = Date()
        let startOfWeek = calendar.date(byAdding: .day, value: -6, to: today)!
        
        // Generate random data for the past week
        for i in 0..<7 {
            let dayDate = calendar.date(byAdding: .day, value: i, to: startOfWeek)!
            
            // Randomly decide if the user exercised or used a freeze streak
            let exercised = Bool.random()
            let froze = Bool.random()
            
            if exercised {
                tracker.daysExercised.append(dayDate)
            } else if froze {
                tracker.freezeStreakDays.append(dayDate)
            }
        }
        
        // Randomize the freeze streak count (1 to 5)
        tracker.freezeStreakCount = Int.random(in: 1...5)
        
        do {
            try repository.saveExerciseTracker(tracker)
        } catch {
            print("Error saving dummy data: \(error)")
        }
    }

    func isTodaysExercise(of type: ExerciseType) -> Bool {
        guard let todaysExercise = self.todaysExercise else { return false }
        return todaysExercise.type == type
    }

    func setTodaysExerciseProgress(_ progress: Int) {
        guard var safeTodaysExercise = self.todaysExercise else { return }
        
        safeTodaysExercise.progress = progress
        
        if safeTodaysExercise.progress >= 100 {
            markCurrentExerciseAsComplete()
        }
    }

    // MARK: - Freeze Streaks

    // Method to consume a freeze streak
    func consumeFreezeStreak() {
        guard let tracker = self.tracker else { return }

        let today = Calendar.current.startOfDay(for: Date())
        
        // Check if the freeze streak has already been consumed today
        if !tracker.freezeStreakDays.contains(where: { $0.isSameDay(as: today) }) {
            if tracker.freezeStreakCount > 0 {
                tracker.freezeStreakCount -= 1
                tracker.freezeStreakDays.append(today)
            } else {
                print("No freeze streaks available to consume.")
            }
        } else {
            print("Freeze streak already consumed today.")
        }
        
        do {
            try repository.saveExerciseTracker(tracker)
        } catch {
            print("Error saving freeze streak consumption: \(error)")
        }
    }

    // Method to fill freeze streak gaps
    func fillFreezeStreakGaps() {
        guard let tracker = self.tracker else { return }
        
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        
        // Determine the start of the week (last Sunday)
        let startOfWeek = calendar.date(byAdding: .day, value: -calendar.component(.weekday, from: today) + 1, to: today)!
        
        // Iterate through each day from startOfWeek to today
        var currentDate = startOfWeek
        while currentDate <= today {
            let isExercised = tracker.daysExercised.contains(where: { $0.isSameDay(as: currentDate) })
            let isFrozen = tracker.freezeStreakDays.contains(where: { $0.isSameDay(as: currentDate) })
            
            // If the day is neither exercised nor frozen, fill the gap with a freeze streak day
            if !isExercised && !isFrozen {
                // Check if there are freeze streaks available to consume
                if tracker.freezeStreakCount > 0 {
                    tracker.freezeStreakDays.append(currentDate)
                    tracker.freezeStreakCount -= 1
//                    print("Filled gap for \(currentDate) as a freeze streak day.")
                } else {
                    print("No freeze streaks available to fill the gap for \(currentDate).")
                }
            }
            
            // Move to the next day
            currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
        }
        
        do {
            try repository.saveExerciseTracker(tracker)
        } catch {
            print("Error saving freeze streak gaps: \(error)")
        }
    }

    // Method to check if the user can use a freeze streak
    func canUseFreezeStreak() -> Bool {
        return tracker?.freezeStreakCount ?? 0 > 0
    }

    func markCurrentExerciseAsComplete() {
        guard let tracker = self.tracker, let _ = self.todaysExercise else { return }
        
        // Update today's exercise
        self.todaysExercise?.progress = 100
        self.todaysExercise?.completionDate = Date()
        
        // Update the last exercise type
        tracker.lastExercise = self.todaysExercise?.type ?? .visualizing
        
        // Update the days exercised array
        let today = Calendar.current.startOfDay(for: Date())
        if !tracker.daysExercised.contains(where: { day in
            let dayComponents = Calendar.current.dateComponents([.year, .month, .day], from: day)
            let todayComponents = Calendar.current.dateComponents([.year, .month, .day], from: today)
            return dayComponents == todayComponents
        }) {
            tracker.daysExercised.append(today)
        }
        
        do {
            try repository.saveExerciseTracker(tracker)
        } catch {
            print("Error saving exercise completion: \(error)")
        }
    }
}
