//
//  File.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 26/4/26.
//

import Foundation

final class IngredientAPIService {
    func fetchIngredients() async throws -> [Ingredient] {
        let request = try IngredientAPI.ingredientsRequest()

        let response = try await APIClient.shared.request(
            request,
            responseType: APIResponse<[Ingredient]>.self
        )
        
        return response.data
    }
}
