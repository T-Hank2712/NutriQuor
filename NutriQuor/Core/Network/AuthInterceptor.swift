//
//  AuthInterceptor.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 24/5/26.
//

import Foundation

final class AuthInterceptor {

    static let shared = AuthInterceptor()

    private var isRefreshing = false
    private var pendingRequests: [(Bool) -> Void] = []

    // MARK: - Handle 401
    func handleUnauthorized(completion: @escaping (Bool) -> Void) {

        pendingRequests.append(completion)

        guard !isRefreshing else { return }

        isRefreshing = true

        Task {
            let success = await refresh()

            isRefreshing = false

            pendingRequests.forEach { $0(success) }
            pendingRequests.removeAll()
        }
    }

    // MARK: - Refresh token
    func refresh() async -> Bool {
        do {
            let response = try await AuthService.shared.refreshAccessToken()

            TokenStorage.shared.saveAccessToken(response.data.accessToken)

            return true
        } catch {
            TokenStorage.shared.clearTokens()
            return false
        }
    }
}
