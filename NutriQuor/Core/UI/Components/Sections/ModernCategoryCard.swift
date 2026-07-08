//
//  ModernCategoryCard.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 29/5/26.
//

import SwiftUI

struct ModernCategoryCard: View {
    let icon: String
    let title: String
    let active: Bool

    var body: some View {
        HStack(spacing: 10) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(active ? Color("ColorPrimary") : Color("ColorPrimary").opacity(0.1))
                    .frame(width: 36, height: 36)

                Image(systemName: icon)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(active ? .white : Color("ColorPrimary"))
            }

            Text(title)
                .font(.system(size: 14, weight: active ? .bold : .medium, design: .rounded))
                .foregroundStyle(active ? Color("ColorPrimary") : .primary)
                .lineLimit(1)

            Spacer()

            if active {
                Image(systemName: "checkmark")
                    .font(.system(size: 11, weight: .bold))
                    .foregroundStyle(Color("ColorPrimary"))
            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: .cardRadius)
                .fill(active
                      ? Color("ColorPrimary").opacity(0.1)
                      : Color(.systemBackground))
                .overlay(
                    RoundedRectangle(cornerRadius: .cardRadius)
                        .stroke(
                            active ? Color("ColorPrimary").opacity(0.24) : Color.primary.opacity(0.05),
                            lineWidth: 1
                        )
                )
                .shadow(color: .black.opacity(active ? 0.02 : 0.03), radius: 8, y: 3)
        )
        .animation(.easeInOut(duration: 0.2), value: active)
    }
}

#Preview {
    VStack(spacing: 16) {
        ModernCategoryCard(icon: "square.grid.2x2.fill", title: "Tất cả", active: true)
        ModernCategoryCard(icon: "drop.degreesign.fill", title: "Thành phần", active: false)
    }
    .padding()
    .background(Color(.systemGroupedBackground))
}
