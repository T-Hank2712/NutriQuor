//
//  NutrientAPIService.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 25/4/26.
//

import Foundation

final class NutrientAPIService {
    func fetchNutrients() async throws -> [Nutrient] {
        let request = try NutrientAPI.nutrientsRequest()

        let response = try await APIClient.shared.request(
            request,
            responseType: APIResponse<[Nutrient]>.self
        )
        
        return response.data
    }
}
