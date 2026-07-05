//
//  ProductAPI.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 8/6/26.
//

import Foundation
import UIKit

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
    
    static func createProduct() throws -> URLRequest {
        guard let url = URL(
            string: "\(AppConfig.shared.devBaseURL)/api/v1/products"
        ) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        return request
    }

    static func analyzeProductRequest(image: UIImage) throws -> URLRequest {
        guard let url = URL(
            string: "\(AppConfig.shared.devBaseURL)/api/v1/products/products/extract"
        ) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        guard let imageData = image.jpegData(compressionQuality: 0.85) else {
            throw URLError(.cannotDecodeContentData)
        }

        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue(
            "multipart/form-data; boundary=\(boundary)",
            forHTTPHeaderField: "Content-Type"
        )

        var body = Data()
        body.append("--\(boundary)\r\n")
        body.append("Content-Disposition: form-data; name=\"file\"; filename=\"scan.jpg\"\r\n")
        body.append("Content-Type: image/jpeg\r\n\r\n")
        body.append(imageData)
        body.append("\r\n")
        body.append("--\(boundary)--\r\n")

        request.httpBody = body

        return request
    }
}

private extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}
