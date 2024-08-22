//
//  BreathingSessionView.swift
//  Mini3-PanicAttack
//
//  Created by tandyys on 20/08/24.
//

import SwiftUI
import Combine
import Buzz

//Inhale: 4sec, Hold: 7sec, Exhale: 8sec
//Repeat: 4 times
enum BreathingType {
    case inhale
    case exhale
    case hold
}

struct BreathingSessionView: View {
    //Audio
    @Environment(ExerciseTrackerViewModel.self) private var viewModel
    @Environment(\.dismiss) private var dismiss
    
    @State var isPlaying = false
    let audioManager = AudioPlayerManager()
    
    //Progress bar
    @State var currentBreathingType: BreathingType = .inhale
    let breathingTypes: [BreathingType] = [.inhale, .hold, .exhale]
    var currentIndex: Int = 0
    @State var progressBarActive = false
    
    //Haptic & Music button
    @State var musicIsTapped = false
    @State var hapticIsTapped = false
    
    //Breath animation state
    @State var breathStateActive = false
    
    //Cycle count
    //@StateObject var cycleCountManager = CycleCountManager()
    @ObservedObject var manager: CycleCountManager
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack {
                Spacer()
                
                if (breathStateActive) {
                    BreathingAnimationComponent(manager: manager)
                } else {
                    BreathingInactiveComponent()
                }
                
                Spacer()
                
                VStack {
                    HStack {
                        Button(action: {
                            print("Haptic Tapped")
                            hapticIsTapped.toggle()
                            if (isPlaying) {
                                audioManager.stop()
                            } else {
                                audioManager.play()
                            }
                        }, label: {
                            if(hapticIsTapped) {
                                HapticButtonComponent(opacityNum: 0.25)
                            } else {
                                HapticButtonComponent(opacityNum: 1)
                            }
                        })
                        
                        if(!isPlaying) {
                            Button(action: {
                                print("Play Tapped")
                                audioManager.play()
                                isPlaying.toggle()
                                progressBarActive.toggle()
                                breathStateActive.toggle()
                                Drone().play()
                            }, label: {
                                PlayButtonComponent()
                            })
                            .padding()
                        } else {
                            Button(action: {
                                print("Stop Tapped")
                                audioManager.stop()
                                isPlaying.toggle()
                                progressBarActive.toggle()
                                breathStateActive.toggle()
                            }, label: {
                                PauseButtonComponent()
                            })
                            .padding()
                        }
                        
                        Button(action: {
                            print("Music Tapped")
                            musicIsTapped.toggle()
                        }, label: {
                            if(musicIsTapped){
                                MusicButtonComponent(opacityNum: 0.25)
                            } else {
                                MusicButtonComponent(opacityNum: 1)
                            }
                            
                        })
                    }
                    .padding(.top, -100)
                }
                
                if(progressBarActive) {
                    ProgressBarComponent()
                        .padding()
                } else {
                    Rectangle()
                        .frame(width: 311, height: 27)
                        .foregroundStyle(.gray.opacity(0.5))
                        .clipShape(.rect(cornerRadius: 27))
                        .padding()
                }
                
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .ignoresSafeArea()
            .background(.white)
            .offset(y: 20)
            
        Image(.blueCross)
            .resizable()
            .frame(width: 32, height: 32)
            .aspectRatio(contentMode: .fill)
            .offset(x: -50, y: 20)
            .onTapGesture {
                dismiss()
            }
        }
    }
}
