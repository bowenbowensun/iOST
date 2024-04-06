//
//  ContentView.swift
//  Practice
//
//  Created by Bowen Sun on 2024-04-02.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem { Image(systemName: "house") }
//                .toolbarBackground(.purple, for: .tabBar)
//                .toolbarBackground(.visible, for: .tabBar)
            SettingsView()
                .tabItem { Image(systemName: "gear") }
                
        }
        .accentColor(.orange)
    }
}

#Preview {
    ContentView()
}
