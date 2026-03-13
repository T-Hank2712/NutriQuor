//
//  ContainList.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 8/3/26.
//

import SwiftUI

struct ContainList: View {
    var body: some View {
        ScrollView{
            VStack(spacing: 20){
                SearchBar(text: .constant(""))
                ProductCard()
                IngredientSection(title: "Ingredients", tag: "6 items")
                IngredientSection(title: "Additives", tag: "6 items")
            }
            .padding()
        }
    }
}

#Preview {
    ContainList()
}
