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
            .toolbar(appState.fullScreenDetailStack.isEmpty ? .visible : .hidden, for: .tabBar)

            CameraButton()

            ForEach(Array(appState.fullScreenDetailStack.enumerated()), id: \.element.id) { index, route in
                route.view
                    .id(route.id)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color("Background"))
                    .ignoresSafeArea()
                    .zIndex(Double(10 + index))
                    .transition(
                        .asymmetric(
                            insertion: .move(edge: .trailing),
                            removal: .move(edge: .trailing)
                        )
                    )
            }
        }
        .animation(.easeInOut(duration: 0.26), value: appState.fullScreenDetailStack.count)
        
    }
}

#Preview {
    ContentView()
        .environmentObject(AppState())
}
