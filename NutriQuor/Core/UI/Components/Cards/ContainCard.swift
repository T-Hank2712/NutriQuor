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
                .foregroundColor(.green)
            Text(bad)
                .foregroundColor(.orange)
        }
        .padding()
        .frame(maxWidth: .infinity, minHeight: 120)
        .background(Color.white)
        .cornerRadius(16)

        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(color, lineWidth: 1)
        )

        .shadow(color: Color.black.opacity(0.02), radius: 6, x: 0, y: 3)
    }
}

#Preview {
    ContainCard(title: "Ingredients", good: "6 Healthy", bad: "2 To Limit", color: .green)
}
