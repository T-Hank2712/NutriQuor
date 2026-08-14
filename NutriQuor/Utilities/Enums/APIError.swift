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

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .unauthorized:
            return "Phiên đăng nhập đã hết hạn. Vui lòng đăng nhập lại."
        case .invalidResponse:
            return "Phản hồi từ hệ thống không hợp lệ. Vui lòng thử lại."
        case .decodingFailed:
            return "Không thể đọc dữ liệu từ hệ thống. Vui lòng thử lại sau."
        case .serverError(let message):
            return message
        }
    }
}
