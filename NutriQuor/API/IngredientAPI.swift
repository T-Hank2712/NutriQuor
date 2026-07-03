//
//  IngredientAPI.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 17/6/26.
//

import Foundation

class IngredientAPI {
    static func ingredientsRequest() throws -> URLRequest {
        guard let url = URL(
            string: "\(AppConfig.shared.devBaseURL)/api/v1/ingredients"
        ) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        return request
    }
}
