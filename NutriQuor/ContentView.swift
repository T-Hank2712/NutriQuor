//
//  ContentView.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 12/1/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            TabView{
                // HOME
                HomeView()
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                // SEARCH
                SearchView()
                    .tabItem {
                        Label("Search", systemImage: "magnifyingglass")
                    }
                // HISTORY
                HistoryView()
                    .tabItem {
                        Label("History", systemImage: "clock.arrow.circlepath")
                    }
                // PROFILE
                ProfileView()
                    .tabItem {
                        Label("Profile", systemImage: "person")
                    }
            }.accentColor(Color(.primary))
            CameraButton()

        }
        
    }
}

#Preview {
    ContentView()
}
