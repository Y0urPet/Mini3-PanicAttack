//
//  Exercise.swift
//  Mini3-PanicAttack
//
//  Created by Althaf Nafi Anwar on 21/08/24.
//

import Foundation
import SwiftUI
import SwiftData

// MARK: - Exercise
// Define an entity for exercises

struct Exercise: Hashable {
    var completionDate: Date?
    var type: ExerciseType
    var progress: Int
    
    init(completionDate: Date? = nil, type: ExerciseType, progress: Int = 0) {
        self.completionDate = completionDate
        self.type = type
        self.progress = progress
    }
}

extension Exercise {
    var isCompleted: Bool {
        return progress >= 100
    }
}
