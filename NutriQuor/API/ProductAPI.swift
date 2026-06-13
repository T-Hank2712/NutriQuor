//
//  ProductAPI.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 8/6/26.
//

import Foundation

final class ProductAPI {
    static func fetchProducts() throws -> URLRequest {
        guard let url = URL(
            string: "\(AppConfig.shared.devBaseURL)/api/v0/products/"
        ) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return request
    }
    
    static func fetchProductsByDate(
        day: Int,
        month: Int,
        year: Int
    ) throws -> URLRequest {
        
        var components = URLComponents(
            string: "\(AppConfig.shared.devBaseURL)/api/v0/products/by-date"
        )

        components?.queryItems = [
            URLQueryItem(name: "day", value: "\(day)"),
            URLQueryItem(name: "month", value: "\(month)"),
            URLQueryItem(name: "year", value: "\(year)")
        ]

        guard let url = components?.url else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        return request
    }
    
    static func countProductsByDate(
        day: Int,
        month: Int,
        year: Int
    ) throws -> URLRequest {
        var components = URLComponents(
            string: "\(AppConfig.shared.devBaseURL)/api/v0/products/count-by-date"
        )

        components?.queryItems = [
            URLQueryItem(name: "day", value: "\(day)"),
            URLQueryItem(name: "month", value: "\(month)"),
            URLQueryItem(name: "year", value: "\(year)")
        ]

        guard let url = components?.url else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        return request
    }
}
