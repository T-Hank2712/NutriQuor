//
//  NutrientAPIService.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 25/4/26.
//

import Foundation

final class NutrientAPIService {
    func fetchNutrients() async throws -> [Nutrient] {
        let url = URL(string: "\(AppConfig.shared.devBaseURL)/api/v0/nutrients")!
        
        let (data, _) = try await URLSession.shared.data(from: url)

        let decoder = JSONDecoder()
        let nutrients = try decoder.decode([Nutrient].self, from: data)

        return nutrients
    }
}
