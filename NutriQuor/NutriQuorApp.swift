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
    var body: some Scene {
        WindowGroup {
            if showContent{
                ContentView()
            }else{
                SplashView(showContent: $showContent)
            }
        }
    }
}
