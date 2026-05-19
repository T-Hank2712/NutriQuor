//
//  CircleButton.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 10/3/26.
//

import SwiftUI

struct CircleButton: View {
    let icon: String
    var body: some View {
        ZStack {
            
            Circle()
                .fill(Color.white.opacity(.opacityLight))
                .frame(width:50,height:50)
                .overlay(
                    Circle()
                        .stroke(Color(.colorPrimary), lineWidth: 2)
                )
            
            Image(systemName: icon)
                .foregroundColor(.black)
        }
    }
}

#Preview {
    CircleButton(icon: "xmark")
}
