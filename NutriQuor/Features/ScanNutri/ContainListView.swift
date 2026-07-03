//
//  ContainList.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 8/3/26.
//

import SwiftUI

struct ContainListView: View {
    let ingredients: [String]
    let additives: [String]

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {

                ProductCard(
                    name: "Sữa",
                    tags: ["Drink", "Healthy"]
                )

                IngredientSection(
                    title: "Ingredients",
                    tag: "\(ingredients.count) items",
                    ingredients: ingredients
                )

                IngredientSection(
                    title: "Additives",
                    tag: "\(additives.count) items",
                    ingredients: additives
                )
            }
            .padding()
        }
    }
}

#Preview {
    ContainListView(
        ingredients: [
            "Spring Water",
            "Citric Acid",
            "Sodium Benzoate"
        ],
        additives: [
            "E202",
            "E330",
            "E211"
        ]
    )
}
