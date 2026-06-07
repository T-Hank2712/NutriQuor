//
//  AuthInterceptor.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 24/5/26.
//

import Foundation

actor AuthInterceptor {

    static let shared = AuthInterceptor()

    private var refreshTask: Task<Bool, Never>?

    func refresh() async -> Bool {
        if let refreshTask {
            return await refreshTask.value
        }

        let task = Task { () -> Bool in
            do {
                let response = try await AuthService.shared.refreshAccessToken()

                let data = response.data   // cache local variable (IMPORTANT)

                TokenStorage.shared.saveAccessToken(data.accessToken)

                if let refreshToken = data.refreshToken {
                    TokenStorage.shared.saveRefreshToken(refreshToken)
                }

                return true
            } catch APIError.unauthorized {
                TokenStorage.shared.clearTokens()
                return false
            } catch {
                return false
            }
        }

        refreshTask = task
        let result = await task.value
        refreshTask = nil

        return result
    }
}
