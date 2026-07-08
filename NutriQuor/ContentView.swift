//
//  ContentView.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 12/1/26.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var appState: AppState

    var body: some View {
        ZStack {
            TabView(selection: $appState.selectedTab) {
                // HOME
                HomeView()
                    .tabItem {
                        Label("Trang chủ", systemImage: "house")
                    }
                    .tag(0)
                // SEARCH
                SearchView()
                    .tabItem {
                        Label("Tra cứu", systemImage: "magnifyingglass")
                    }
                    .tag(1)
                // HISTORY
                HistoryView()
                    .tabItem {
                        Label("Lịch sử", systemImage: "clock.arrow.circlepath")
                    }
                    .tag(2)
                // PROFILE
                SettingView()
                    .tabItem {
                        Label("Hồ sơ", systemImage: "person")
                    }
                    .tag(3)
            }
            .tint(Color.nqPrimary)
            .toolbarBackground(.ultraThinMaterial, for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
            .animation(.spring(response: 0.34, dampingFraction: 0.82), value: appState.selectedTab)
            CameraButton()

        }
        
    }
}

#Preview {
    ContentView()
        .environmentObject(AppState())
}
