import SwiftUI

struct GenericAnimatedWaveWithImage: View {
    @State private var thirdBackgroundOpacity = 1.0
    @State private var secondBackgroundOpacity = 1.0
    @State private var firstBackgroundOpacity = 1.0
    
    @State private var scaling = 1.0
    let totalDuration: Double = 0.5
    
    var animated: Bool
    var image: ImageResource
    
    var body: some View {
        ZStack {
            // The biggest
            Image("CloudThree")
                .opacity(thirdBackgroundOpacity)
            
            Image("CloudTwo")
                .opacity(secondBackgroundOpacity)
            
            // The smallest
            Image("CloudOne")
                .opacity(firstBackgroundOpacity)
            
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 300, height: 300)
        }
        .onAppear {
            if animated {
                startAnimationSequence()
            } else {
                resetAnimation() // Reset opacity if not animated
            }
        }
        .onChange(of: animated) {
            if animated {
                startAnimationSequence()
            } else {
                resetAnimation() // Reset when animation is turned off
            }
        }
    }
    
    func startAnimationSequence() {
        // INHALE YOUR BREATH for 4 seconds
        withAnimation(Animation.linear(duration: totalDuration + 0.25)) {
            thirdBackgroundOpacity = 0.1
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation(Animation.linear(duration: totalDuration)) {
                secondBackgroundOpacity = 0.1
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            withAnimation(Animation.linear(duration: totalDuration)) {
                firstBackgroundOpacity = 0.1
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            withAnimation(Animation.linear(duration: totalDuration)) {
                firstBackgroundOpacity = 1
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            withAnimation(Animation.linear(duration: totalDuration)) {
                secondBackgroundOpacity = 1
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
            withAnimation(Animation.linear(duration: totalDuration)) {
                thirdBackgroundOpacity = 1
            }
        }
        
        // Restart the animation sequence after it completes
        DispatchQueue.main.asyncAfter(deadline: .now() + 9) {
            startAnimationSequence()
        }
    }
    
    func resetAnimation() {
        // Reset the opacity values to their initial states with a small animation
        withAnimation(Animation.linear(duration: 0.5)) {
            thirdBackgroundOpacity = 1.0
            secondBackgroundOpacity = 1.0
            firstBackgroundOpacity = 1.0
        }
    }
}
