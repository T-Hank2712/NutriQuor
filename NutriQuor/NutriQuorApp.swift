//
//  NutriQuorApp.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 12/1/26.
//

import SwiftUI

@main
struct NutriQuorApp: App {
    
    @State private var showContent = false
    @AppStorage("app_theme") private var appTheme: String = AppearanceMode.system.rawValue
    
    var body: some Scene {
        WindowGroup {
            Group {
                if showContent {
                    ContentView()
                } else {
                    SplashView(showContent: $showContent)
                }
            }
            .preferredColorScheme(
                AppearanceMode(rawValue: appTheme)?.colorScheme
            )
            .onChange(of: appTheme) { oldValue, newValue in
                applyTheme(newValue)
            }
            .onAppear {
                applyTheme(appTheme)
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
                case .light:
                    return .light
                case .dark:
                    return .dark
                case .system:
                    return .unspecified
                }
            }()
            
            windowScene.windows.forEach { window in
                window.overrideUserInterfaceStyle = style
            }
        }
    }
}
