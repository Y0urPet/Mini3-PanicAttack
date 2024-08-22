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
    
    

    init(lastExercise: ExerciseType = .visualizing, freezeStreakCount: Int = 5, dailyStreaks: [DailyStreak] = []) {
        self.lastExercise = lastExercise
        self.freezeStreakCount = freezeStreakCount
        self.dailyStreaks = dailyStreaks
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
        for (index, streak) in sortedStreaks.enumerated().reversed() {
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
