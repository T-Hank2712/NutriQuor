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
                
                // HISTORY
                HistoryView()
                    .tabItem {
                        Label("History", systemImage: "clock.arrow.circlepath")
                    }
                
                Color.clear.tabItem {
                    Label("", systemImage: "")
                }
                // ANALYST
                AnalystView()
                    .tabItem {
                        Label("Analyst", systemImage: "chart.bar.xaxis")
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
