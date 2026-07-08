//
//  ModernContainCard.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 8/6/26.
//

import SwiftUI

struct ModernContainCard: View {
    let title: String
    let good: String
    let bad: String
    let goodColor: Color
    let badColor: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.system(size: 13, weight: .bold, design: .rounded))
                .foregroundStyle(.primary)

            if !good.isEmpty {
                HStack(spacing: 6) {
                    Circle().fill(goodColor).frame(width: 7, height: 7)
                    Text(good)
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundStyle(goodColor)
                }
            }

            if !bad.isEmpty {
                HStack(spacing: 6) {
                    Circle().fill(badColor).frame(width: 7, height: 7)
                    Text(bad)
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundStyle(badColor)
                }
            }
        }
        .frame(maxWidth: .infinity, minHeight: 70, alignment: .top)
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: .cardRadius)
                .fill(Color("Background"))
                .overlay(
                    RoundedRectangle(cornerRadius: .cardRadius)
                        .stroke(Color.primary.opacity(0.06), lineWidth: 1)
                )
        )
    }
}

#Preview {
    ModernContainCard(
        title: "Thành phần",
        good: "6 Tốt",
        bad: "2 Hạn chế",
        goodColor: Color("SuccessTeal"),
        badColor: Color("WarningAmber")
    )
}
