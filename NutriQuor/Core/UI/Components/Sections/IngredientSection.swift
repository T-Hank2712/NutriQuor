//
//  IngredientSection.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 8/3/26.
//

import SwiftUI

struct IngredientSection: View {
    let title: String
    let tag: String
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            HStack {
                Text(title)
                    .font(.headline)
                
                Spacer()
                
                Tag(text: tag, color: .gray)
            }
            
            IngredientCard(
                title: "Spring Water",
                description: "Natural source of hydration and essential minerals for daily metabolic functions.",
                status: .safe
            )
            IngredientCard(
                title: "Citric Acid",
                description: "Common preservative and acidity regulator. Moderate consumption is generally acceptable.",
                status: .moderate
            )
            IngredientCard(
                title: "Sodium Benzoate",
                description: "Synthetic preservative that may cause adverse reactions when combined with ascorbic acid.",
                status: .caution
            )
        }
    }
}

#Preview {
    IngredientSection(title: "Ingredients", tag: "6 Items")
}
