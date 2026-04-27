//
//  StatCard.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 30/1/26.
//

import SwiftUI

struct StatCard: View {
    let nutri: Nutrient
    let icon: String
    let iconColor: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {

            HStack {
                Text(nutri.name)
                    .foregroundColor(.secondary)
                Spacer()
                Image(systemName: icon).foregroundColor(iconColor)
            }

            HStack(alignment: .lastTextBaseline, spacing: 4) {
                Text(String(format: "%.2f", nutri.name))
                    .font(.title)
                    .fontWeight(.bold)
                Text(nutri.name)
                    .font(.headline)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: .cardRadius)
                .stroke(Color.gray.opacity(.opacityMedium))
        )
    }
}

#Preview {
    StatCard(nutri: Nutrient(id: 1, name: "Calories", description: "100", image: "", effects: [
        HealthEffect(
            id: 1,
            title: "Weight Loss"
        ),
        HealthEffect(
            id: 2,
            title: "Neurological Effects",
        ),
        HealthEffect(
            id: 3,
            title: "PKU Warning",
        ),
    ],
                             found_in: [
                                 FoodCategory(
                                     id: 1,
                                     name: "Sữa"
                                 ),
                                 FoodCategory(
                                     id: 2,
                                     name: "Bánh"
                                 ),
                                 FoodCategory(
                                     id: 1,
                                     name: "Trái cây"
                                 )
                             ]), icon: "flame", iconColor: .red)
}
