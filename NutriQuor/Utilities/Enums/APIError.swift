//
//  APIError.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 24/5/26.
//

import Foundation

enum APIError: Error {
    case unauthorized
    case invalidResponse
    case decodingFailed
    case serverError(String)
}
