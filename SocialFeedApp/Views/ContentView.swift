//
//  ContentView.swift
//  SocialFeedApp
//
//  Created by Prabhakaran on 27/10/25.
//

import SwiftUI

struct ContentView: View {

    @State private var selectedTab = 0
    var body: some View {
        TabView(selection: $selectedTab) {
            FeedView()
                .tabItem {
                    Label("Feed", systemImage: "house.fill")
                }
                .tag(0)

            CreatePostView(selectedTab: $selectedTab)
                .tabItem {
                    Label("Create", systemImage: "plus.circle.fill")
                }
                .tag(1)
        }
    }
}
