//
//  NutriQuorApp.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 12/1/26.
//

import SwiftUI

@main
struct NutriQuorApp: App {

    @StateObject private var appState = AppState()

    @AppStorage("app_theme") private var appTheme: String = AppearanceMode.light.rawValue

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(appState)
                .preferredColorScheme(
                    AppearanceMode(rawValue: appTheme)?.colorScheme
                )
                .onChange(of: appTheme) { _, newValue in
                    applyTheme(newValue)
                }
                .onAppear {
                    applyTheme(appTheme)
                    Task {
                        await appState.bootstrap()
                    }
                }
        }
    }

    private func applyTheme(_ themeValue: String) {
        guard let mode = AppearanceMode(rawValue: themeValue) else { return }

        DispatchQueue.main.async {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
                return
            }

            let style: UIUserInterfaceStyle = {
                switch mode {
                case .light: return .light
                case .dark: return .dark
                case .system: return .unspecified
                }
            }()

            windowScene.windows.forEach { window in
                window.overrideUserInterfaceStyle = style
            }
        }
    }
}

struct RootView: View {
    
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        Group {
            switch appState.authState {
            
            case .loading:
                ProgressView()
                
            case .login:
                LoginView(appState: appState)
                
            case .register:
                RegisterView()
                
            case .loggedIn:
                ContentView()
            }
        }
        .animation(.easeInOut, value: appState.authState)
    }
}
