//
//  ExerciseTrackerModel.swift
//  Mini3-PanicAttack
//
//  Created by Althaf Nafi Anwar on 20/08/24.
//

import Foundation
import SwiftUI
import SwiftData


struct DailyStreak: Codable, Hashable {
    var date: Date
    var streakType: StreakType
}


enum StreakType: String, CaseIterable, Codable, Hashable {
    case exercise
    case frozen
    case skipped
    
    static func random() -> StreakType {
        return StreakType.allCases.randomElement() ?? .skipped
    }
    
    var icon: ImageResource {
        switch self {
        case .exercise:
            return .fire
        case .frozen:
            return .blueFire
        case .skipped:
            return .fireSkeleton
        }
    }
}


// MARK: - ExerciseTracker

@Model class ExerciseTracker {
    var lastExercise: ExerciseType
    var freezeStreakCount: Int
    var dailyStreaks: [DailyStreak]
    
    

    init(lastExercise: ExerciseType = .visualizing, freezeStreakCount: Int = 2, dailyStreaks: [DailyStreak] = []) {
        self.lastExercise = lastExercise
        self.freezeStreakCount = freezeStreakCount
        self.dailyStreaks = dailyStreaks
    }
}

extension ExerciseTracker {
    func currentStreak(min: Int) -> Int {
        let validStreaks = getStreakData(min: min)
        
        guard !validStreaks.isEmpty else { return 0 }
        
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        var yesterday = calendar.date(byAdding: .day, value: -1, to: today)!
        
        // Filter daily streaks up to today
        let filteredStreaks = validStreaks.filter { calendar.startOfDay(for: $0.date) <= today }
        
        // Initialize variables for counting streaks
        var currentStreakCount = 0
        
        let sortedStreaks = validStreaks.sorted { calendar.startOfDay(for: $0.date) < calendar.startOfDay(for: $1.date) }
        
        // Iterate through filtered streaks in reverse order to check from today and backwards
        for (_, streak) in sortedStreaks.enumerated().reversed() {
            if calendar.isDate(today, equalTo: streak.date, toGranularity: .day) {
                continue // Skip if it is today
            }
            
            // Streak checker
            if calendar.isDate(yesterday, equalTo: streak.date, toGranularity: .day) {
                currentStreakCount += 1
                // Decrement
                yesterday = calendar.date(byAdding: .day, value: -1, to: yesterday)!
            } else {
                break
            }
        }
        
        // Check if today's streak is not empty
        if let lastStreak = filteredStreaks.last(where: { calendar.startOfDay(for: $0.date) == today }) {
            if lastStreak.streakType != .skipped {
                currentStreakCount += 1
            }
        }
        
        return currentStreakCount
    }
    
    func getStreakData(min: Int) -> [DailyStreak] {
        guard !dailyStreaks.isEmpty else { return [] }

        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        var currentDay = calendar.startOfDay(for: Date()) // Set as today
        
        
        var startOfWeek = calendar.date(byAdding: .day, value: -calendar.component(.weekday, from: today) + 1, to: today)!
        // Set time to start of day (morning)
        startOfWeek = calendar.startOfDay(for: startOfWeek)
        
        // Sort daily streaks by date in ascending order
        let sortedStreaks = dailyStreaks.sorted { calendar.startOfDay(for: $0.date) < calendar.startOfDay(for: $1.date) }
//        print(sortedStreaks)

        // Initialize variables for counting streaks
        var streakData: [DailyStreak] = []
        
        var subStreak: [DailyStreak] = []
        
        var idx = sortedStreaks.count - 1
        // Iterate through filtered streaks in reverse order to check from today and backwards
        
        
        // Loop through every day before today and if went past start of week @ Sunday
        //
        while idx >= 0 {
            // If the same day as currentDay, if not continue
            // Check if subStreakCount >= min, if yes append to streakData, if not continue
            
            if currentDay < startOfWeek {
                break
            }
            
            // Streak checker //
            // Loop through everyday by decrementing day until outside of week
            // Check through the array if date is same
            if calendar.isDate(currentDay, equalTo: sortedStreaks[idx].date, toGranularity: .day) {
                print(idx, subStreak.count, sortedStreaks[idx])
                subStreak.append(sortedStreaks[idx])
                
                // Decrement idx if found
                idx -= 1
                
            // If calendar is not on streak
            } else {
                // Add to streakData if above min
                if subStreak.count >= min {
                    print("appending: \(subStreak.count)")
                    streakData.append(contentsOf: subStreak)
                }
                // Reset subStreak
                subStreak = []
            }
            
            // Add to streakData if above min
            if subStreak.count >= min {
                print("appending: \(subStreak.count)")
                streakData.append(contentsOf: subStreak)
            }
            
            // Decrement to they day before
            currentDay = calendar.date(byAdding: .day, value: -1, to: currentDay)!
        }
        
        return streakData
    }

}


// ExerciseTracker.swift (continued)
extension ExerciseTracker {
    var currentStreak: Int {
        guard !dailyStreaks.isEmpty else { return 0 }
        
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        var yesterday = calendar.date(byAdding: .day, value: -1, to: today)!
        
        // Filter daily streaks up to today
        let filteredStreaks = dailyStreaks.filter { calendar.startOfDay(for: $0.date) <= today }
        
        // Initialize variables for counting streaks
        var currentStreakCount = 0
        
        let sortedStreaks = dailyStreaks.sorted { calendar.startOfDay(for: $0.date) < calendar.startOfDay(for: $1.date) }
        
        // Iterate through filtered streaks in reverse order to check from today and backwards
        for (_, streak) in sortedStreaks.enumerated().reversed() {
            if calendar.isDate(today, equalTo: streak.date, toGranularity: .day) {
                continue // Skip if it is today
            }
            
            // Streak checker
            if calendar.isDate(yesterday, equalTo: streak.date, toGranularity: .day) {
                currentStreakCount += 1
                // Decrement
                yesterday = calendar.date(byAdding: .day, value: -1, to: yesterday)!
            } else {
                break
            }
        }
        
        // Check if today's streak is not empty
        if let lastStreak = filteredStreaks.last(where: { calendar.startOfDay(for: $0.date) == today }) {
            if lastStreak.streakType != .skipped {
                currentStreakCount += 1
            }
        }
        
        return currentStreakCount
    }
}

// ExerciseTracker.swift (continued)
extension ExerciseTracker {
    func longestStreak(from: Date, to: Date) -> Int {
        guard !dailyStreaks.isEmpty else { return 0 }
        
        let calendar = Calendar.current
        
        // Determine start and end of week (last Sunday and next Saturday)
        var startOfWeek = calendar.date(byAdding: .day, value: -calendar.component(.weekday, from: from) + 1, to: from)!
        
        // Set time to start of day (morning)
        startOfWeek = calendar.startOfDay(for: startOfWeek)
        
        // Determine end of week (next Saturday)
        var endOfWeek = calendar.date(byAdding: .day, value: 6, to: startOfWeek)!
        
        // Set time to end of day (tonight)
        endOfWeek = calendar.date(byAdding: .second, value: -1, to: calendar.date(byAdding: .day, value: 1, to: endOfWeek)!)!
        
        // Filter daily streaks within specified range
        let filteredStreaks = dailyStreaks.filter { calendar.startOfDay(for: $0.date) >= startOfWeek && calendar.startOfDay(for: $0.date) <= endOfWeek }
        
        // Initialize variables for counting longest streaks
        var longestStreakCount = 1
        
        // Iterate through filtered streaks to count longest consecutive streaks
        for (index, streak) in filteredStreaks.enumerated() {
            if index < filteredStreaks.count - 1 && calendar.isDate(filteredStreaks[index + 1].date, inSameDayAs: streak.date.addingTimeInterval(86400)) {
                longestStreakCount += 1
            } else {
                break
            }
        }
        
        return longestStreakCount
    }
}
