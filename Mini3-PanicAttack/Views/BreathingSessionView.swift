//
//  BreathingSessionView.swift
//  Mini3-PanicAttack
//
//  Created by tandyys on 20/08/24.
//

import SwiftUI

struct BreathingSessionView: View {
    @State var isPlaying = false
    
    @State var time = 0
    @State var timer: Timer?
    
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
                            startTimer()
                            isPlaying.toggle()
                        }, label: {
                            PlayButtonComponent()
                        })
                        .padding()
                    } else {
                        Button(action: {
                            print("Stop Tapped")
                            audioManager.stop()
                            stopTimer()
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
                
                //                TimerComponent(elapsedTime: time)
                //                    .padding()
                RoundedRectangle(cornerRadius: 25)
                    .frame(width: 113, height: 48)
                    .foregroundStyle(Color.init(hex: 0xD6DCF1))
                    .overlay {
                        //Dummy time
                        if(time >= 10) {
                            Text("00:\(time)")
                                .font(Font.custom("Rubik-SemiBold", size: 17))
                                .foregroundStyle(Color.init(hex: 0x3350B8))
                        } else {
                            Text("00:0\(time)")
                                .font(Font.custom("Rubik-SemiBold", size: 17))
                                .foregroundStyle(Color.init(hex: 0x3350B8))
                        }
                    }
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
