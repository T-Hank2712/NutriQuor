//
//  APIClient.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 24/5/26.
//

import Foundation

final class APIClient {
    static let shared = APIClient()
    private init() {}

    // MARK: - CASE 1: API CÓ RESPONSE
    func request<T: Decodable>(
        _ request: URLRequest,
        responseType: T.Type
    ) async throws -> T {

        return try await perform(request, responseType: responseType, retry: true)
    }

    func requestWithoutRetry<T: Decodable>(
        _ request: URLRequest,
        responseType: T.Type
    ) async throws -> T {

        return try await perform(
            request,
            responseType: responseType,
            retry: false,
            attachAccessToken: false
        )
    }

    // MARK: - CASE 2: API KHÔNG RETURN DATA
    func request(
        _ request: URLRequest
    ) async throws {

        _ = try await perform(request, responseType: EmptyResponse.self, retry: true)
    }

    // MARK: - CORE (AUTO REFRESH + RETRY)
    private func perform<T: Decodable>(
        _ request: URLRequest,
        responseType: T.Type,
        retry: Bool,
        attachAccessToken: Bool = true
    ) async throws -> T {

        do {
            var req = request
            if attachAccessToken {
                attachToken(&req)
            }

            let (data, response) = try await URLSession.shared.data(for: req)

            try validate(response, data)

            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601

            return try decoder.decode(T.self, from: data)

        } catch let error as APIError {

            if case .unauthorized = error, retry {

                let refreshed = await AuthInterceptor.shared.refresh()

                if refreshed {
                    return try await perform(
                        request,
                        responseType: responseType,
                        retry: false
                    )
                }
            }

            throw error
        }
    }

    // MARK: - VALIDATION
    private func validate(_ response: URLResponse, _ data: Data) throws {
        guard let http = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }

        guard 200...299 ~= http.statusCode else {

            if http.statusCode == 401 {
                throw APIError.unauthorized
            }

            var serverMessage = "Yêu cầu chưa thực hiện được. Vui lòng thử lại."

            if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
               let message = json["message"] as? String ?? json["detail"] as? String {
                serverMessage = Self.userFriendlyServerMessage(message)
            }

            throw APIError.serverError(serverMessage)
        }
    }

    private static func userFriendlyServerMessage(_ message: String) -> String {
        switch message {
        case "Token không hợp lệ":
            return "Phiên đăng nhập không hợp lệ. Vui lòng đăng nhập lại."
        case "Missing API Key. Please provide X-API-Key header",
             "Invalid API Key":
            return "Ứng dụng chưa được cấu hình quyền truy cập phù hợp."
        case "Cannot connect to Builder analyze service",
             "Builder analyze request failed":
            return "Hệ thống phân tích đang bận. Vui lòng thử lại sau."
        case "Scan history storage is not available":
            return "Lịch sử quét hiện chưa sẵn sàng. Vui lòng thử lại sau."
        case "Scan history not found":
            return "Không tìm thấy lịch sử quét này."
        case "Uploaded image is empty":
            return "Ảnh tải lên đang trống. Vui lòng chọn ảnh khác."
        case "Uploaded image is too large":
            return "Ảnh quá lớn. Vui lòng chọn ảnh có dung lượng nhỏ hơn."
        default:
            return message
        }
    }

    // MARK: - TOKEN ATTACH
    private func attachToken(_ request: inout URLRequest) {

        guard let token = TokenStorage.shared.getAccessToken() else {
            return
        }

        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    }
}

// MARK: - EMPTY RESPONSE
struct EmptyResponse: Decodable {}
