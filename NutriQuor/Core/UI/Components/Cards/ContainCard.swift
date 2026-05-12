//
//  ContainCard.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 7/3/26.
//

import SwiftUI

struct ContainCard: View {
    let title: String
    let good: String
    let bad: String
    let color: Color
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack{
                Image(systemName: "carrot").foregroundStyle(color)
                Text(title)
                    .fontWeight(.semibold)
            }
            Text(good)
                .foregroundColor(Color(.primary))
            Text(bad)
                .foregroundColor(Color(.badHealth))
        }
        .padding()
        .frame(maxWidth: .infinity, minHeight: 120)
        .background(Color(.systemBackground))
        .cornerRadius(.cardRadius)

        .overlay(
            RoundedRectangle(cornerRadius: .cardRadius)
                .stroke(color, lineWidth: 1)
        )

        .shadow(color: Color.black.opacity(.opacityLight), radius: 6, x: 0, y: 3)
    }
}

#Preview {
    ContainCard(title: "Ingredients", good: "6 Healthy", bad: "2 To Limit", color: .green)
}
