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
            return "Deep Breathing"
        case .grounding:
            return "Grounding"
        case .HALT:
            return "H.A.L.T"
        case .PMR:
            return "PMR"
        case .thinking:
            return "Think Clearly"
        case .visualizing:
            return "Visualization"
        }
    }
    
    var description: String {
        switch self {
        case .breathing:
            return "Find calm with each breath djwoduhw iwodwdh diwhdiwodh"
        case .grounding:
            return "Stay present through your senses"
        case .HALT:
            return "Being mindful of your current emotions"
        case .PMR:
            return "Relax your muscle and ease tension gradually"
        case .thinking:
            return "Shift your perspective into a more positive one"
        case .visualizing:
            return "Picture your calm and think more clearly"
        }
    }
    
    var imageThumb: ImageResource {
        switch self {
        case .breathing:
            return .thumbBreathing
        case .grounding:
            return .thumbGrounding
        case .HALT:
            return .thumbHalt
        case .PMR:
            return .thumbPmr
        case .thinking:
            return .thumbThinking
        case .visualizing:
            return .thumbVisualizing
        }
    }
}
