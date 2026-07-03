//
//  AdditiveAPI.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 17/6/26.
//

import Foundation

class AdditiveAPI{
    static func additivesRequest() throws -> URLRequest {
        guard let url = URL(
            string: "\(AppConfig.shared.devBaseURL)/api/v1/additives"
        ) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        return request
    }
}
