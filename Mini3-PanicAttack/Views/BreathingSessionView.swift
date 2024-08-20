//
//  BreathingSessionView.swift
//  Mini3-PanicAttack
//
//  Created by tandyys on 20/08/24.
//

import SwiftUI

struct BreathingSessionView: View {
    @State var isPlaying = false
    let audioManager = AudioPlayerManager()
    var body: some View {
        VStack {
            //dummy spacer
            Spacer()
            
            BreathingAnimationComponent()
            
            Spacer()
            
            VStack {
                HStack {
                    Button(action: {
                        print("Haptic Tapped")
                    }, label: {
                        HapticButtonComponent()
                    })
                    
                    if(!isPlaying) {
                        Button(action: {
                            print("Play Tapped")
                            audioManager.play()
                            isPlaying.toggle()
                        }, label: {
                            PlayButtonComponent()
                        })
                        .padding()
                    } else {
                        Button(action: {
                            print("Stop Tapped")
                            audioManager.stop()
                            isPlaying.toggle()
                        }, label: {
                            PauseButtonComponent()
                        })
                        .padding()
                    }
                    
                    Button(action: {
                        print("Music Tapped")
                    }, label: {
                        MusicButtonComponent()
                    })
                }
                .padding(.top, -100)
                
                TimerComponent()
                    .padding()
            }
            
            //dummy spacer
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .ignoresSafeArea()
        .background(.white)
    }
}

#Preview {
    BreathingSessionView()
}
