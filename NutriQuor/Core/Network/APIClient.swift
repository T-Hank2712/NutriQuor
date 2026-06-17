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
            print("❌ Invalid response type:", response)
            throw URLError(.badServerResponse)
        }

        print("\n================ API RESPONSE ================")
        print("🔵 URL:", http.url?.absoluteString ?? "unknown")
        print("🔵 Status Code:", http.statusCode)
        print("🔵 Headers:", http.allHeaderFields)

        // Try decode JSON pretty
        if let jsonObject = try? JSONSerialization.jsonObject(with: data),
           let prettyData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted),
           let prettyString = String(data: prettyData, encoding: .utf8) {
            print("🔵 Body (JSON pretty):\n", prettyString)
        } else {
            print("🔵 Body (raw):\n", String(data: data, encoding: .utf8) ?? "nil")
        }

        print("=============================================\n")

        guard 200...299 ~= http.statusCode else {

            if http.statusCode == 401 {
                print("❌ Unauthorized (401) - check token or auth header")
                throw APIError.unauthorized
            }

            // Try extract message field nếu backend trả JSON kiểu {message: ...}
            var serverMessage = "Request failed"

            if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
               let message = json["message"] as? String {
                serverMessage = message
            }

            print("❌ API ERROR MESSAGE:", serverMessage)

            throw APIError.serverError(serverMessage)
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
