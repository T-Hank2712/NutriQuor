//
//  SearchView.swift
//  NutriQuor
//

import SwiftUI

struct SearchView: View {

    @StateObject var viewModel = SearchNutritionViewModel()
    @State private var selectedCategory: NutritionCategory = .all

    private let categories: [(icon: String, title: String, category: NutritionCategory)] = [
        ("square.grid.2x2.fill", "Tất cả",       .all),
        ("drop.degreesign.fill", "Thành phần",    .ingredient),
        ("plus.square.fill",     "Phụ gia",       .additive),
        ("pill.fill",            "Dinh dưỡng",    .nutrient)
    ]

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 24) {

                    // MARK: - Header
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Khám phá")
                            .font(.system(size: 28, weight: .black, design: .rounded))
                            .foregroundStyle(.primary)
                            .kerning(-0.3)
                        Text("Tìm kiếm thành phần & dinh dưỡng")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundStyle(.secondary)
                    }
                    .padding(.top, 8)

                    // MARK: - Search Bar
                    SearchBar(text: $viewModel.query)

                    // MARK: - Mode Switch
                    if viewModel.isSearching {
                        searchResults
                    } else {
                        normalContent
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 32)
            }
            .background(Color("Background"))
            .onAppear {
                Task { await viewModel.loadByCategory(selectedCategory) }
            }
        }
    }

    // MARK: - Category Select
    private func selectCategory(_ category: NutritionCategory) {
        guard selectedCategory != category else { return }
        selectedCategory = category
        Task { await viewModel.loadByCategory(category) }
    }

    // MARK: - Normal Content
    private var normalContent: some View {
        VStack(alignment: .leading, spacing: 20) {

            // Category chips
            VStack(alignment: .leading, spacing: 12) {
                SectionLabel(text: "DANH MỤC")

                LazyVGrid(
                    columns: [GridItem(.flexible()), GridItem(.flexible())],
                    spacing: 12
                ) {
                    ForEach(categories, id: \.title) { item in
                        ModernCategoryCard(
                            icon: item.icon,
                            title: item.title,
                            active: selectedCategory == item.category
                        )
                        .onTapGesture { selectCategory(item.category) }
                    }
                }
            }

            // List
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    SectionLabel(text: "KẾT QUẢ")
                    Spacer()
                    if !viewModel.filteredList.isEmpty {
                        Text("\(viewModel.filteredList.count) mục")
                            .font(.system(size: 12, weight: .semibold, design: .rounded))
                            .foregroundStyle(Color("ColorPrimary"))
                    }
                }

                if viewModel.filteredList.isEmpty {
                    EmptySearchState(isSearching: false)
                } else {
                    VStack(spacing: 10) {
                        ForEach(viewModel.filteredList, id: \.id) { item in
                            NavigationLink {
                                SearchDetailView(id: item.id)
                            } label: {
                                ModernProductCard(
                                    name: item.displayName,
                                    tags: [item.displayCode, item.type.displayTypeName].compactMap { $0 },
                                    description: item.description,
                                    type: item.type
                                )
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
            }
        }
    }

    // MARK: - Search Results
    private var searchResults: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                SectionLabel(text: "KẾT QUẢ TÌM KIẾM")
                Spacer()
                if !viewModel.filteredList.isEmpty {
                    Text("\(viewModel.filteredList.count) mục")
                        .font(.system(size: 12, weight: .semibold, design: .rounded))
                        .foregroundStyle(Color("ColorPrimary"))
                }
            }

            if viewModel.filteredList.isEmpty {
                EmptySearchState(isSearching: true)
            } else {
                VStack(spacing: 10) {
                    ForEach(viewModel.filteredList, id: \.id) { item in
                        NavigationLink {
                            SearchDetailView(id: item.id)
                        } label: {
                            ModernProductCard(
                                name: item.displayName,
                                tags: [item.displayCode, item.type.displayTypeName].compactMap { $0 },
                                description: item.description,
                                type: item.type
                            )
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }
    }
}

#Preview {
    SearchView()
}

private extension String {
    var displayTypeName: String {
        switch self {
        case "ingredient": return "Thành phần"
        case "nutrient": return "Dinh dưỡng"
        case "additive": return "Phụ gia"
        default: return self
        }
    }
}
