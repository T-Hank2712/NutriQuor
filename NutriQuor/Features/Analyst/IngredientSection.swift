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
                statusColor: .green
            )
            
            IngredientCard(
                title: "Organic Italian Almonds (7%)",
                description: "Rich in Vitamin E and healthy monounsaturated fats that support heart health.",
                statusColor: .green
            )
            
            IngredientCard(
                title: "Sea Salt",
                description: "Essential mineral, but should be limited to maintain healthy blood pressure levels.",
                statusColor: .orange
            )
            
            IngredientCard(
                title: "Rice Starch",
                description: "A gluten-free thickener that provides a smooth texture without chemical processing.",
                statusColor: .green
            )
        }
    }
}

#Preview {
    IngredientSection(title: "Ingredients", tag: "6 Items")
}
