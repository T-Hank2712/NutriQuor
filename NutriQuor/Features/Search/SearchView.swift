
//
//  AnalystView.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 12/1/26.
//

import SwiftUI

struct SearchView: View {
    @StateObject var viewModel = SearchNutritionViewModel()
    @State private var selectedCategory: NutritionCategory = .all
    var body: some View {
        NavigationStack {
            ScrollView {

                VStack(alignment: .leading, spacing: 16) {

                    SearchBar(text: .constant(""))

                    Text("History Search")

                    HStack {
                        TagWithXmark(text: "Vitamin D3", color: .gray)
                        TagWithXmark(text: "Sugar", color: .gray)
                    }

                    Text("Category")
                        .font(.title)

                    HStack {
                        CategoryCard(icon: "heart.fill", title: "All", active: selectedCategory == .all)
                            .onTapGesture {
                                selectCategory(.all)
                            }
                        CategoryCard(icon: "drop.degreesign.fill", title: "Ingredients", active: selectedCategory == .ingredient)
                            .onTapGesture {
                            selectCategory(.ingredient)
                        }
                    }

                    HStack {
                        CategoryCard(icon: "plus.square.fill", title: "Additives", active: selectedCategory == .additive)
                            .onTapGesture {
                                selectCategory(.additive)
                            }
                        CategoryCard(icon: "pill.fill", title: "Nutrients", active: selectedCategory == .nutrient)
                            .onTapGesture {
                            selectCategory(.nutrient)
                        }
                    }

                    ForEach(viewModel.list, id: \.id) { item in
                        NavigationLink {
                            SearchDetailView(data: item)
                        } label: {
                            ProductCard(name: item.name, tags: [item.code, item.type].compactMap { $0 })
                        }
                    }
                }
                .padding(.horizontal)
            }
            .task(id: selectedCategory) {
                await viewModel.loadByCategory(selectedCategory)
            }
        }
    }
    private func selectCategory(_ category: NutritionCategory) {
        guard selectedCategory != category else { return }
        selectedCategory = category
    }
}



#Preview {
    SearchView()
}
