//
//  AudioPlayerProtocol.swift
//  Mini3-PanicAttack
//
//  Created by tandyys on 20/08/24.
//

import Foundation

protocol AudioPlayer {
    func play()
    func stop()
    func isPlaying() -> Bool
}
