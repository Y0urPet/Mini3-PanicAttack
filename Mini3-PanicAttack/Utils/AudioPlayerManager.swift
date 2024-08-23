//
//  AudioPlayerManager.swift
//  Mini3-PanicAttack
//
//  Created by tandyys on 20/08/24.
//

import Foundation
import AVFoundation

class AudioPlayerManager: AudioPlayer {
    var audioPlayer: AVAudioPlayer?
    func playSession() {
        guard let soundpath = Bundle.main.path(forResource: "breathingExerciseSound", ofType: "mp3") else {
            return print("error load music")
        }
        let soundUrl = URL(fileURLWithPath: soundpath)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundUrl)
            audioPlayer?.play()
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
        }
    }
    
    func playCongrats() {
        guard let soundpath = Bundle.main.path(forResource: "congratsSound", ofType: "mp3") else {
            return print("error load music")
        }
        let soundUrl = URL(fileURLWithPath: soundpath)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundUrl)
            audioPlayer?.play()
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
        }
    }
    
    func stop() {
        audioPlayer?.stop()
    }
    
    func isPlaying() -> Bool {
        return true
    }
}
