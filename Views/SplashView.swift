//
//  SplashView.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 12/1/26.
//

import SwiftUI

struct SplashView: View {
    @Binding var showContent: Bool

    var body: some View {
        VStack {
            Image("Logo")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation {
                    showContent = true
                }
            }
        }
    }
}


#Preview {
    SplashView(showContent: .constant(false))
}
