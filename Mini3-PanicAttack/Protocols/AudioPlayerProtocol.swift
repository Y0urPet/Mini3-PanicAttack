//
//  AudioPlayerProtocol.swift
//  Mini3-PanicAttack
//
//  Created by tandyys on 20/08/24.
//

import Foundation

protocol AudioPlayer {
    func playSession()
    func playCongrats()
    func stop()
    func isPlaying() -> Bool
}
