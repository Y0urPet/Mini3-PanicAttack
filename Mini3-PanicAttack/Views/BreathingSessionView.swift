//
//  BreathingSessionView.swift
//  Mini3-PanicAttack
//
//  Created by tandyys on 20/08/24.
//

import SwiftUI
import Combine

//Inhale: 4sec, Hold: 7sec, Exhale: 8sec
//Repeat: 4 times
enum BreathingType {
    case inhale
    case exhale
    case hold
    
}

struct BreathingSessionView: View {
    //Audio
    @State var isPlaying = false
    let audioManager = AudioPlayerManager()
    
    //Progress bar
    @State var currentBreathingType: BreathingType = .inhale
    let breathingTypes: [BreathingType] = [.inhale, .hold, .exhale]
    var currentIndex: Int = 0
    @State var inhaleAnimation = false
    @State var holdAnimation = false
    @State var exhaleAnimation = false
    
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
                
                
            }
//            
//            if currentBreathingType == .hold {
//                ProgressBarComponent(breathingType: currentBreathingType)
//                    .padding()
//            } else if currentBreathingType == .exhale {
//                ProgressBarComponent(breathingType: currentBreathingType)
//                    .padding()
//            } else {
//                ProgressBarComponent(breathingType: currentBreathingType)
//                    .padding()
//            }
            ProgressBarComponent()
            
            //dummy spacer
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .ignoresSafeArea()
        .background(.white)
//        .onAppear {
//            
//        }
    }
}
//
#Preview {
    BreathingSessionView()
}
