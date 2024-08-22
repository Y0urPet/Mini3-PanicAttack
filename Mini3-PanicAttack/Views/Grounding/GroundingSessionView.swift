//
//  GroundingSessionView.swift
//  Mini3-PanicAttack
//
//  Created by Althaf Nafi Anwar on 22/08/24.
//

import SwiftUI
import Combine
import Buzz

//Inhale: 4sec, Hold: 7sec, Exhale: 8sec
//Repeat: 4 times

struct GroundingSessionContent {
    var title: String
    var subTitle: String
    var image: ImageResource
}


struct GroundingSessionView: View {
    //Audio
    @Environment(ExerciseTrackerViewModel.self) private var viewModel
    @Environment(\.dismiss) private var dismiss
    
    @State var isPlaying = false
    let audioManager = AudioPlayerManager()
    
    //Haptic & Music button
    @State var musicIsTapped = false
    @State var hapticIsTapped = false
    
    //Breath animation state
    @State var breathStateActive = false
    
    //@StateObject var cycleCountManager = CycleCountManager()
    @ObservedObject var manager: CycleCountManager
    
    var content: [GroundingSessionContent] = [
        GroundingSessionContent(title: "5 Things You See", subTitle: "Look around and name five things you can see.", image: .grounding1),
        GroundingSessionContent(title: "4 Things You Can Touch", subTitle: "Focus on four things you can physically touch, like the texture of your clothing or the surface of the chair.", image: .grounding2),
        GroundingSessionContent(title: "3 Things You Can Hear", subTitle: "Tune in to three different sounds around you, like the ticking of a clock, the hum of distant traffic, or birds chirping.", image: .grounding3),
        GroundingSessionContent(title: "2 Things You Can Smell", subTitle: "Notice two distinct smells around you;if needed, move around to find something to sniff.", image: .grounding4),
        GroundingSessionContent(title: "1 Thing You Can Taste", subTitle: "Pay attention to the taste in your mouth, or take a sip of something to notice the flavor.", image: .grounding5),
    ]
    
    @State var contentIndex = 0
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Text(content[contentIndex].title)
                        .font(.system(size: 24))
                        .fontWeight(.bold)
                        .foregroundStyle(.black)
                    Spacer()
                }
                .multilineTextAlignment(.center)
                
                HStack {
                    Text(content[contentIndex].subTitle)
                        .font(.system(size: 16))
                        .fontWeight(.regular)
                        .foregroundStyle(.neutral500)
                }
                .padding(.horizontal, 75)
                .padding(.top, 2)
                .multilineTextAlignment(.center)
                
                GenericAnimatedWaveWithImage(animated: isPlaying ? true : false, image: content[contentIndex].image)
                
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
                        
                        if (!isPlaying) {
                            Button(action: {
                                print("Play Tapped")
                                audioManager.play()
                                isPlaying.toggle()
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
                                print(isPlaying)
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
                    
                    HStack {
                        Spacer()
                            Button(action: {
                                if (contentIndex + 1) >= content.count {
                                    // End of the session, mark as complete by changing
                                    // cycle manager data to true
                                    
                                    manager.isCycleFinished = true
                                    
                                } else {
                                    // If not then actually increment index
                                    contentIndex += 1
                                }
                                
                            }, label: {
                                Text("Next")
                                    .font(Font.custom("Rubik-SemiBold", size: 17))
                                    .foregroundStyle(.white)
                                    .frame(width: UIScreen.main.bounds.width - 80, height: 48)
                                    .background(.primary600)
                                    .clipShape(.rect(cornerRadius: 53))
                            })
                            .padding(.top, 10)
                            .padding(.bottom, 32)
                        
                        Spacer()
                    }
                }
                
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .ignoresSafeArea()
            .offset(y: 20)
            .background(.neutral100)
            
        Image(.blueCross)
            .resizable()
            .frame(width: 32, height: 32)
            .aspectRatio(contentMode: .fill)
            .offset(x: -50, y: 20)
            .onTapGesture {
                dismiss()
            }
        }
        .background(.neutral100)
    }
}
