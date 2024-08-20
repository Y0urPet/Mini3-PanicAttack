//
//  MainView.swift
//  Mini3-PanicAttack
//
//  Created by Timothy Andrian on 19/08/24.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            CheckInView()
                .tabItem {
                    Image(systemName: "face.smiling.inverse")
                    Text("Check-in")
                }
            ExploreView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Explore")
                }
            ProfileView()
                .tabItem {
                    Image(systemName: "person.crop.circle.fill")
                    Text("Profile")
                }
        }
    }
}

#Preview {
    MainView()
}
