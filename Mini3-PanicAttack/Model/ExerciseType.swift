//
//  ExerciseType.swift
//  Mini3-PanicAttack
//
//  Created by Althaf Nafi Anwar on 21/08/24.
//

import Foundation
import SwiftUI
import SwiftData

enum ExerciseType: Codable {
    case breathing
    case grounding
    case HALT
    case PMR
    case thinking
    case visualizing
    
    
    func getNext() -> ExerciseType {
        switch self {
        case .breathing:
            return .grounding
        case .grounding:
            return .HALT
        case .HALT:
            return .PMR
        case .PMR:
            return .thinking
        case .thinking:
            return .visualizing
        case .visualizing:
            return .breathing
        }
    }
    
    var title: String {
        switch self {
        case .breathing:
            return "Breathing Exercise"
        case .grounding:
            return "Grounding Technique"
        case .HALT:
            return "H.A.L.T Technique"
        case .PMR:
            return "Progressive Muscle Relaxation"
        case .thinking:
            return "Stop Catastrophic Thinking"
        case .visualizing:
            return "Visualization Exercise"
        }
    }
    
    var description: String {
        switch self {
        case .breathing:
            return "Breathing Exercise"
        case .grounding:
            return "Grounding Technique"
        case .HALT:
            return "H.A.L.T Technique"
        case .PMR:
            return "Progressive Muscle Relaxation"
        case .thinking:
            return "Stop Catastrophic Thinking"
        case .visualizing:
            return "Visualization Exercise"
        }
    }
    
    var imageThumb: ImageResource {
        switch self {
        case .breathing:
            return .thumbBreathing
        case .grounding:
            return .thumbBreathing
        case .HALT:
            return .thumbBreathing
        case .PMR:
            return .thumbBreathing
        case .thinking:
            return .thumbBreathing
        case .visualizing:
            return .thumbBreathing
        }
    }
}
