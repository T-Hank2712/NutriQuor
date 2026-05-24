//
//  AuthService.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 14/5/26.
//

import Foundation

final class AuthService {
    static let shared = AuthService()
    private init() {}

    private let client = APIClient.shared

    // REGISTER
    func register(
        firstName: String,
        lastName: String,
        email: String,
        password: String,
        confirmPassword: String
    ) async throws {

        let request = try AuthAPI.registerRequest(
            firstName: firstName,
            lastName: lastName,
            email: email,
            password: password,
            confirmPassword: confirmPassword
        )

        try await APIClient.shared.request(request)
    }

    // LOGIN
    func login(email: String, password: String) async throws -> APIResponse<TokenData> {
        let request = try AuthAPI.loginRequest(email: email, password: password)

        return try await APIClient.shared.request(
            request,
            responseType: APIResponse<TokenData>.self
        )
    }

    // GET ME
    func getMe() async throws -> APIResponse<MeResponse> {

        guard let token = TokenStorage.shared.getAccessToken() else {
            throw URLError(.userAuthenticationRequired)
        }

        let request = try AuthAPI.meRequest(token: token)

        return try await APIClient.shared.request(
            request,
            responseType: APIResponse<MeResponse>.self
        )
    }
    
    // Refresh Access Token
    func refreshAccessToken() async throws -> APIResponse<RefreshData> {

        guard let refreshToken = TokenStorage.shared.getRefreshToken() else {
            throw URLError(.userAuthenticationRequired)
        }

        let request = try AuthAPI.refreshAccessTokenRequest(refreshToken: refreshToken)

        let response = try await APIClient.shared.request(
            request,
            responseType: APIResponse<RefreshData>.self
        )

        return response
    }
}
