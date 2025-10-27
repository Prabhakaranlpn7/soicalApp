//
//  SplashView.swift
//  SocialFeedApp
//
//  Created by Prabhakaran on 28/10/25.
//

import SwiftUI


struct SplashView: View {
    @State private var isActive = false

    var body: some View {
        if isActive {
            ContentView()
        } else {
            VStack {
                Image("splashscreen")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                   
                
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        isActive = true
                    }
                }
            }
        }
    }
}
