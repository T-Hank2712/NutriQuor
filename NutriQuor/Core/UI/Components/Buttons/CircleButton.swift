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
                .fill(Color(.secondarySystemBackground))
                .frame(width:50,height:50)
                .overlay(
                    Circle()
                        .stroke(Color.nqPrimary.opacity(0.35), lineWidth: 1)
                )
            
            Image(systemName: icon)
                .foregroundColor(Color.nqPrimary)
        }
    }
}

#Preview {
    CircleButton(icon: "xmark")
}
