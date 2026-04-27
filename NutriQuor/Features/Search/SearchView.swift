import SwiftUI

struct SearchView: View {
    
    @StateObject var viewModel = SearchNutritionViewModel()
    @State private var selectedCategory: NutritionCategory = .all
    
    var body: some View {
        NavigationStack {
            ScrollView {
                
                VStack(alignment: .leading, spacing: 16) {
                    
                    // SEARCH BAR
                    SearchBar(text: $viewModel.query)
                    
                    // SWITCH UI MODE
                    if viewModel.isSearching {
                        searchResults
                    } else {
                        normalContent
                    }
                }
                .padding(.horizontal)
            }
            .onAppear {
                Task {
                    await viewModel.loadByCategory(selectedCategory)
                }
            }
        }
    }
    
    // MARK: - CATEGORY SELECT
    private func selectCategory(_ category: NutritionCategory) {
        guard selectedCategory != category else { return }
        
        selectedCategory = category
        
        Task {
            await viewModel.loadByCategory(category)
        }
    }
    
    // MARK: - NORMAL UI
    private var normalContent: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            HStack {
                CategoryCard(icon: "heart.fill",
                             title: "All",
                             active: selectedCategory == .all)
                .onTapGesture { selectCategory(.all) }
                
                CategoryCard(icon: "drop.degreesign.fill",
                             title: "Ingredients",
                             active: selectedCategory == .ingredient)
                .onTapGesture { selectCategory(.ingredient) }
            }
            
            HStack {
                CategoryCard(icon: "plus.square.fill",
                             title: "Additives",
                             active: selectedCategory == .additive)
                .onTapGesture { selectCategory(.additive) }
                
                CategoryCard(icon: "pill.fill",
                             title: "Nutrients",
                             active: selectedCategory == .nutrient)
                .onTapGesture { selectCategory(.nutrient) }
            }
            
            // LIST (normal mode)
            ForEach(viewModel.filteredList, id: \.id) { item in
                NavigationLink {
                    SearchDetailView(data: item)
                } label: {
                    ProductCard(
                        name: item.name,
                        tags: [item.code, item.type].compactMap { $0 }
                    )
                }
            }
        }
    }
    
    // MARK: - SEARCH UI
    private var searchResults: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            ForEach(viewModel.filteredList, id: \.id) { item in
                NavigationLink {
                    SearchDetailView(data: item)
                } label: {
                    ProductCard(
                        name: item.name,
                        tags: [item.code, item.type].compactMap { $0 }
                    )
                }
            }
            
            if viewModel.filteredList.isEmpty {
                Text("No results found")
                    .foregroundColor(.secondary)
                    .padding(.top, 20)
            }
        }
    }
}

#Preview {
    SearchView()
}
