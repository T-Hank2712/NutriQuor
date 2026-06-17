//
//  SearchAPI.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 15/6/26.
//

import Foundation

class SearchAPI {
    static func searchRequest() throws -> URLRequest {
        guard let url = URL(
            string: "\(AppConfig.shared.devBaseURL)/api/v1/search"
        ) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        return request
    }
    
    static func searchDetailRequest(id: String) throws -> URLRequest {
        guard let url = URL(
            string: "\(AppConfig.shared.devBaseURL)/api/v1/search/\(id)"
        ) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        return request
    }
    
    static func dailyFeatureRequest() throws -> URLRequest {
        guard let url = URL(
            string: "\(AppConfig.shared.devBaseURL)/api/v1/search/daily"
        ) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        return request
    }
}
