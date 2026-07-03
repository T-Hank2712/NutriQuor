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
    let ingredients: [String]?

    private var status: IngredientStatus {
        title.lowercased() == "ingredients" ? .safe : .caution
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {

            HStack {
                Text(title)
                    .font(.headline)

                Spacer()

                Tag(text: tag, color: .gray)
            }

            if let ingredients = ingredients {
                ForEach(ingredients, id: \.self) { item in
                    IngredientCard(
                        title: item,
                        status: status
                    )
                }
            }
        }
    }
}

#Preview {
    IngredientSection(
        title: "Ingredients",
        tag: "3 Items",
        ingredients: [
            "Spring Water",
            "Citric Acid",
            "Sodium Benzoate"
        ]
    )
}
