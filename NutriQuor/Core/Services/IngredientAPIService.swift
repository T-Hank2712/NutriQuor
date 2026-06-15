//
//  File.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 26/4/26.
//

import Foundation

final class IngredientAPIService {
    func fetchIngredients() async throws -> [Ingredient] {
        let url = URL(string: "\(AppConfig.shared.devBaseURL)/api/v1/ingredients")!
        
        let (data, _) = try await URLSession.shared.data(from: url)

        let decoder = JSONDecoder()
        let ingredients = try decoder.decode([Ingredient].self, from: data)

        return ingredients
    }
}
