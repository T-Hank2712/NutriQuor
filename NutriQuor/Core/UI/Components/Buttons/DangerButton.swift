//
//  DangerButton.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 7/6/26.
//

import SwiftUI

struct DangerButton: View {
    let title: String
    let icon: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.system(size: 16, weight: .semibold))
                
                Text(title)
                    .font(.system(size: 16, weight: .bold, design: .rounded))
            }
            .foregroundStyle(color)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(color.opacity(0.08))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(color.opacity(0.25), lineWidth: 1.5)
                    )
            )
        }
    }
}

#Preview {
    DangerButton(    title: "Đăng xuất",
                     icon: "rectangle.portrait.and.arrow.right",
                     color: Color("AccentPink"),
                     action: {}
    )
}
