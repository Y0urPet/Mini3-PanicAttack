//
//  InMemoryExerciseTrackerRepository.swift
//  Mini3-PanicAttack
//
//  Created by Althaf Nafi Anwar on 21/08/24.
//

import Foundation
import Foundation

class InMemoryExerciseTrackerRepository: ExerciseTrackerRepository {
    private var data: [ExerciseTracker]

    init(data: [ExerciseTracker] = []) {
        self.data = data
    }

    func fetchExerciseTracker() -> ExerciseTracker? {
        return data.first
    }

    func saveExerciseTracker(_ tracker: ExerciseTracker) {
        // For dummy data, we don't need to save it persistently.
        // However, if you want to keep track of changes, you could add them to the dummyData array.
        
        // For simplicity, we'll just print the changes.
        
        // If you want to keep track of changes, uncomment the following line.
        print("Appending to in-memory store")
        data.append(tracker)
    }

    func insertDefaultExerciseTracker() -> ExerciseTracker {
        let singletonTracker = ExerciseTracker(lastExercise: .visualizing, daysExercised: [])
        return singletonTracker
    }
}
