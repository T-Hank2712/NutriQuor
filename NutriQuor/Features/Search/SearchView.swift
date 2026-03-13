
//
//  AnalystView.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 12/1/26.
//

import SwiftUI

struct SearchView: View {
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                SearchBar(text: .constant(""))
                Text("History Search")
                HStack{
                    TagCanDelete(text: "Vitamin D3", color: .gray)
                    TagCanDelete(text: "Sugar", color: .gray)
                }
                Text("Category").font(.title)
                HStack{
                    CategoryCard(icon: "pill.fill", title: "Vitamins", active: true)
                    CategoryCard(icon: "drop.degreesign.fill", title: "E-Numbers")
                }
                HStack{
                    CategoryCard(icon: "plus.square.fill", title: "Additives")
                    CategoryCard(icon: "heart.fill", title: "Healthys")
                }
                ForEach(0..<5) { index in
                    ProductCard()
                }
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
        }
    }
}

#Preview {
    SearchView()
}
