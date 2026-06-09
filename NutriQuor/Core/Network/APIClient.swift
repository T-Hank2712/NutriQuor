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
            throw URLError(.badServerResponse)
        }

        print("STATUS:", http.statusCode)
        print(String(data: data, encoding: .utf8) ?? "")

        guard 200...299 ~= http.statusCode else {

            if http.statusCode == 401 {
                throw APIError.unauthorized
            }

            let message = String(data: data, encoding: .utf8) ?? "Request failed"
            throw APIError.serverError(message)
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
