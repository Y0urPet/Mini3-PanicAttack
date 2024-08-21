//
//  ExerciseTrackerRepository.swift
//  Mini3-PanicAttack
//
//  Created by Althaf Nafi Anwar on 21/08/24.
//

import SwiftData
import Foundation

protocol ExerciseTrackerRepository {
    func fetchExerciseTracker() throws -> ExerciseTracker?
    func saveExerciseTracker(_ tracker: ExerciseTracker) throws
    func insertDefaultExerciseTracker() throws -> ExerciseTracker
}
