//
//  ExerciseTrackerRepositoryImpl.swift
//  Mini3-PanicAttack
//
//  Created by Althaf Nafi Anwar on 21/08/24.
//

import Foundation
import SwiftData


class PersistentExerciseTrackerRepository: ExerciseTrackerRepository {
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func fetchExerciseTracker() throws -> ExerciseTracker? {
        do {
            let descriptor = FetchDescriptor<ExerciseTracker>()
            if let tracker = try modelContext.fetch(descriptor).first {
                return tracker
            } else {
                return nil
            }
        } catch {
            throw error
        }
    }
    
    func saveExerciseTracker(_ tracker: ExerciseTracker) throws {
        do {
            try  modelContext.save()
        } catch {
            throw error
        }
    }
    
    func insertDefaultExerciseTracker()  throws -> ExerciseTracker {
        let singletonTracker = ExerciseTracker(lastExercise: .visualizing, daysExercised: [])
        modelContext.insert(singletonTracker)
        return singletonTracker
    }
}
