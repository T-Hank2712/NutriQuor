//
//  ModernNutrientCard.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 8/6/26.
//

import SwiftUI

struct ModernNutrientCard: View {
    let title: String
    let value: String
    let color: Color
    let icon: String

    var body: some View {
        VStack(spacing: 10) {
            ZStack {
                Circle()
                    .fill(color.opacity(0.1))
                    .frame(width: 44, height: 44)
                Image(systemName: icon)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(color)
            }
            Text(value)
                .font(.system(size: 20, weight: .black, design: .rounded))
                .foregroundStyle(.primary)
            Text(title)
                .font(.system(size: 10, weight: .bold, design: .rounded))
                .foregroundStyle(.secondary)
                .kerning(0.5)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .background(
            RoundedRectangle(cornerRadius: .cardRadius)
                .fill(color.opacity(0.05))
                .overlay(
                    RoundedRectangle(cornerRadius: .cardRadius)
                        .stroke(color.opacity(0.15), lineWidth: 1)
                )
        )
    }
}

#Preview {
    ModernNutrientCard(title: "PROTEIN", value: "8g",  color: Color("AccentPink"), icon: "flame.fill")
}
