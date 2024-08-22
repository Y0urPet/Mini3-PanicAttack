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
        
        self.repository = PersistentExerciseTrackerRepository(modelContext: modelContext)
//        self.repository = InMemoryExerciseTrackerRepository()
        
        load()
    }

    func isTodaysExercise(of exercise: ExerciseType) -> Bool {
        return todaysExercise?.type == exercise
    }
    
    func load() {
        do {
            if let tracker = try repository.fetchExerciseTracker() {
                self.tracker = tracker
            } else {
                let singletonTracker = try repository.insertDefaultExerciseTracker()
                self.tracker = singletonTracker
            }
            
            // Set today's exercise based on last finished exercise
            self.todaysExercise = Exercise(type: tracker?.lastExercise.getNext() ?? .breathing, progress: 0)
            
            // If end of month add freezeStreakCount
            // TODO: Fix this, to add freeze streak at the end of month
//            self.refreshFreezeStreak()
            
        } catch {
            print("Fetch failed: \(error)")
        }
    }
    
    func loadDummyData() {
        guard let tracker = self.tracker else { return }
        
        let calendar = Calendar.current
        let today = Date()
        let startOfWeek = calendar.date(byAdding: .day, value: -6, to: today)!
        
        // Generate random data for the past week
        for i in 0..<7 {
            let dayDate = calendar.date(byAdding: .day, value: i, to: startOfWeek)!
            
            // Randomly decide if the user exercised or used a freeze streak
            let randomStreakType: StreakType = StreakType.random()
            
            if !(randomStreakType == .skipped) {
                tracker.dailyStreaks.append(DailyStreak(date: dayDate, streakType: randomStreakType))
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
    
    
    func refreshFreezeStreak() {
        guard let tracker = self.tracker else { return }
        
        let calendar = Calendar.current
        let today = Date()
        
        // Get the components of today's date
        let todayComponents = calendar.dateComponents([.year, .month], from: today)
        
        // Get the components of tomorrow's date
        let tomorrowComponents = calendar.dateComponents([.year, .month], from: calendar.date(byAdding: .day, value: 1, to: today)!)
        
        // Check if today is the last day of the month
        if todayComponents.year == tomorrowComponents.year && todayComponents.month == tomorrowComponents.month {
            tracker.freezeStreakCount += 3
        }
        
        // Save the updated tracker
        do {
            try repository.saveExerciseTracker(tracker)
        } catch {
            print("Error saving tracker: \(error)")
        }
    }
    
    func markTodaysAsCompleted() {
        setTodaysProgress(to: 100)
    }
    
    func setTodaysProgress(to progress: Int) {
        guard let tracker = self.tracker else { return }

        // Update the progress of the current exercise
        if var todaysExercise = self.todaysExercise {
            
            // Check if the exercise is complete
            if progress >= 100 {
                todaysExercise.completionDate = Date()
                
                // Update the last exercise type for next day's exercise
                tracker.lastExercise = todaysExercise.type
                
                // Check if there is already a daily streak entry for today
                if let existingStreak = tracker.dailyStreaks.first(where: { Calendar.current.startOfDay(for: $0.date) == Calendar.current.startOfDay(for: Date()) }) {
                    print("No need to add new daily streak entry for today")
                } else {
                    // Add a new daily streak entry
                    tracker.dailyStreaks.append(DailyStreak(date: Calendar.current.startOfDay(for: Date()), streakType: .exercise))
                }
                
                todaysExercise.progress = 100
                self.todaysExercise?.progress = 100
                
            } else {
                todaysExercise.progress = progress
                self.todaysExercise?.progress = progress
            }
            
            // Save the updated exercise
            do {
                try repository.saveExerciseTracker(tracker)
            } catch {
                print("Error saving exercise: \(error)")
            }
        }
    }
    
    
    func consumeFreezeStreak(for date: Date) {
        guard let tracker = self.tracker else { return }

        // Get the calendar to work with dates
        let calendar = Calendar.current

        // Convert the given date to start of day
        let dayDate = calendar.startOfDay(for: date)

        // Check if there is already an entry for this day in dailyStreaks
        if let existingStreak = tracker.dailyStreaks.first(where: { calendar.startOfDay(for: $0.date) == dayDate }) {
            // If the existing streak is of type .skipped, update it to .frozen
            print("Unable to freeze streak for: \(existingStreak.date) of type \(existingStreak.streakType)")
        } else {
            // If no entry exists, create a new one with type .frozen
            tracker.dailyStreaks.append(DailyStreak(date: dayDate, streakType: .frozen))
        }

        // Save the updated tracker
        do {
            try repository.saveExerciseTracker(tracker)
        } catch {
            print("Error saving tracker: \(error)")
        }
    }
    
    func autoFreezeStreaks() {
        guard let tracker = self.tracker else { return }

        // Determine start and end of week (last Sunday and next Saturday)
        let calendar = Calendar.current
        let today = Date()
        let todayStartOfDay = calendar.startOfDay(for: today)
        
        var startOfWeek = calendar.date(byAdding: .day, value: -calendar.component(.weekday, from: today) + 1, to: today)!
        
        // Set time to start of day (morning)
        startOfWeek = calendar.startOfDay(for: startOfWeek)

        // Determine end of week (next Saturday)
        var endOfWeek = calendar.date(byAdding: .day, value: 6, to: startOfWeek)!
        
        // Set time to end of day (tonight)
        endOfWeek = calendar.date(byAdding: .second, value: -1, to: calendar.date(byAdding: .day, value: 1, to: endOfWeek)!)!

        // Generate all days in the week
        var allDaysInWeek: [Date] = []
        var currentDate = startOfWeek
        while currentDate <= endOfWeek {
            allDaysInWeek.append(calendar.startOfDay(for: currentDate))
            currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
        }

        // Find empty days in the week before today's start of day
        let emptyDays = allDaysInWeek.filter { day in
            !tracker.dailyStreaks.contains(where: { calendar.startOfDay(for: $0.date) == day }) && calendar.startOfDay(for: day) < todayStartOfDay
        }
        
        // Append new entries with type .frozen for empty days
        for day in emptyDays {
            if tracker.freezeStreakCount <= 0 {
                break
            }
            
            tracker.dailyStreaks.append(DailyStreak(date: day, streakType: .frozen))
            tracker.freezeStreakCount -= 1 
        }

        // Save the updated tracker
        do {
            try repository.saveExerciseTracker(tracker)
        } catch {
            print("Error saving tracker: \(error)")
        }
    }
}
