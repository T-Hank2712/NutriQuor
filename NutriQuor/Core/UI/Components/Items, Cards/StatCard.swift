//
//  StatCard.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 30/1/26.
//

import SwiftUI

struct StatCard: View {
    let nutri: Nutrition
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
                Text(String(format: "%.2f", nutri.value))
                    .font(.title)
                    .fontWeight(.bold)
                Text(nutri.unit)
                    .font(.headline)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.gray.opacity(0.2))
        )
    }
}

#Preview {
    StatCard(nutri: Nutrition(name: "Calories", unit: "kcal", value: 50.0), icon: "flame", iconColor: .red)
}
