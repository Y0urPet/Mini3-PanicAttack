//
//  ExerciseTrackerModel.swift
//  Mini3-PanicAttack
//
//  Created by Althaf Nafi Anwar on 20/08/24.
//

import Foundation
import SwiftUI
import SwiftData

// MARK: - ExerciseTracker

@Model class ExerciseTracker {
    var lastExercise: ExerciseType
    var daysExercised: [Date]
    var freezeStreakCount: Int
    var freezeStreakDays: [Date]

    init(lastExercise: ExerciseType = .visualizing, daysExercised: [Date] = [], freezeStreakCount: Int = 4, freezeStreakDays: [Date] = []) {
        self.lastExercise = lastExercise
        self.daysExercised = daysExercised
        self.freezeStreakCount = freezeStreakCount
        self.freezeStreakDays = freezeStreakDays
    }
}


extension ExerciseTracker {
    // TODO: Streak sometimes miscalculated
    
    var longestStreak: Int {
        // Combine the days exercised and freeze streak days
        var allDays = daysExercised + freezeStreakDays
        
        // Remove duplicates and sort the dates
        allDays = Array(Set(allDays)).sorted()

        // Get the current date and calendar
        let calendar = Calendar.current
        let today = Date()
        
        // Determine the start of the week (last Sunday)
        var startOfWeek = calendar.date(byAdding: .day, value: -calendar.component(.weekday, from: today) + 1, to: today)!
        
        // Set the time to the start of the day (morning)
        startOfWeek = calendar.startOfDay(for: startOfWeek)
        
        // Determine the end of the week (next Saturday)
        let endOfWeek = calendar.date(byAdding: .day, value: 6, to: startOfWeek)!
        
        // Set the time to the start of the day (morning)
        let endOfWeekStart = calendar.startOfDay(for: endOfWeek)

        // Filter allDays to only include days within the current week
        let weekDays = allDays.filter { day in
            return day >= startOfWeek && day <= endOfWeekStart
        }

        guard !weekDays.isEmpty else { return 0 }
        
        var currentStreak = 1
        var longestStreak = 1
        
        for index in 1..<weekDays.count {
            // Check if the current day is the next day after the previous day
            if calendar.isDate(weekDays[index], inSameDayAs: weekDays[index - 1].addingTimeInterval(86400)) {
                currentStreak += 1
            } else {
                currentStreak = 1 // Reset current streak if the sequence is broken
            }
            
            longestStreak = max(longestStreak, currentStreak)
        }
        
        return longestStreak
    }
    
    var currentStreak: Int {
        // Combine the days exercised and freeze streak days
        var allDays = daysExercised + freezeStreakDays
        
        // Remove duplicates and sort the dates
        allDays = Array(Set(allDays)).sorted()

        // Get the current date and calendar
        let calendar = Calendar.current
        let today = Date()
        
        // Determine the start of the week (last Sunday)
        var startOfWeek = calendar.date(byAdding: .day, value: -calendar.component(.weekday, from: today) + 1, to: today)!
        
        // Set the time to the start of the day (morning)
        startOfWeek = calendar.startOfDay(for: startOfWeek)
        
        // Determine the end of the week (next Saturday)
        let endOfWeek = calendar.date(byAdding: .day, value: 6, to: startOfWeek)!
        
        // Set the time to the end of the day (tonight)
        let endOfWeekEnd = calendar.date(byAdding: .second, value: -1, to: calendar.date(byAdding: .day, value: 1, to: endOfWeek)!)!

        // Filter allDays to only include days within the current week
        let weekDays = allDays.filter { day in
            return day >= startOfWeek && day <= endOfWeekEnd
        }

        guard !weekDays.isEmpty else { return 0 }
        
        var currentStreak = 1
        
        for index in 1..<weekDays.count {
            // Check if the current day is the next day after the previous day
            if calendar.isDate(weekDays[index], inSameDayAs: weekDays[index - 1].addingTimeInterval(86400)) {
                currentStreak += 1
            } else {
                currentStreak = 1 // Reset current streak if the sequence is broken
            }
        }
        
        return currentStreak
    }
    
    func printExerciseAndFreezeDays() {
        // Combine the days exercised and freeze streak days
        var allDays = daysExercised + freezeStreakDays
        
        // Remove duplicates and sort the dates
        allDays = Array(Set(allDays)).sorted()

        // Create a dictionary to track the activities for each date
        var activityDict: [Date: [String]] = [:]

        // Populate the dictionary with activities
        for day in allDays {
            var activities = [String]()
            if daysExercised.contains(where: { $0.isSameDay(as: day) }) {
                activities.append("Exercised")
            }
            if freezeStreakDays.contains(where: { $0.isSameDay(as: day) }) {
                activities.append("Frozen")
            }
            activityDict[day] = activities
        }

        // Print the results
        for (date, activities) in activityDict {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE, MMM d, yyyy" // Format the date
            let formattedDate = dateFormatter.string(from: date)
            let activityDescription = activities.joined(separator: " and ")
            print("\(formattedDate): \(activityDescription)")
        }
    }
}
