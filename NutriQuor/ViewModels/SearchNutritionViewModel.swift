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
    @Published var nutrients: [Nutrient] = []
    private let service = NutrientAPIService()

    func loadAll() async {
        do {
            async let nutrients = service.fetchNutrients()

            let result = try await nutrients

            self.nutrients = result

        } catch {
            print("Error loading data:", error)
        }
    }
}
