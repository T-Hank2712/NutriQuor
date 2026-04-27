//
//  SearchNutritionViewModel.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 25/4/26.
//

import Foundation
import Combine

@MainActor
final class SearchNutritionViewModel: ObservableObject {
    @Published  private var selectedCategory: NutritionCategory = .nutrient

    @Published var list: [SearchDTO] = []
    private let searchService = SearchService()
    private let nutrientService = NutrientAPIService()
    private let ingredientService = IngredientAPIService()
    private let additiveService = AdditiveAPIService()

    func loadAll() async {
        do {
            async let task = searchService.fetchAllItem()
            let result = try await task
            self.list = result

        } catch {
            print("Error loading data:", error)
        }
    }
    
    func loadByCategory(_ category: NutritionCategory) async {
        do {
            switch category {
            case .all:
                await loadAll()
            case .nutrient:
                let data = try await nutrientService.fetchNutrients()
                self.list = data.map { $0.toSearchDTO() }

            case .ingredient:
                let data = try await ingredientService.fetchIngredients()
                self.list = data.map { $0.toSearchDTO() }
            case .additive:
                let data = try await additiveService.fetchAdditives()
                self.list = data.map { $0.toSearchDTO() }
            }
            
        } catch {
            print("Error loading data:", error)
        }
    }
}
