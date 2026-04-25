
//
//  AnalystView.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 12/1/26.
//

import SwiftUI

struct SearchView: View {
    @StateObject var viewModel = SearchNutritionViewModel()
    var body: some View {
        NavigationStack{
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    SearchBar(text: .constant(""))
                    Text("History Search")
                    HStack{
                        TagWithXmark(text: "Vitamin D3", color: .gray)
                        TagWithXmark(text: "Sugar", color: .gray)
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
                    LazyVStack {
                        ForEach(viewModel.nutrients) { item in
                            NavigationLink(destination: SearchDetailView(data: item)) {
                                ProductCard(
                                    name: item.name,
                                    tags: ["Drink", "Healthy"]
                                )
                            }
                        }
                    }
                    .task {
                        await viewModel.loadAll()
                    }
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            }
        }
    }
}

#Preview {
    SearchView()
}
