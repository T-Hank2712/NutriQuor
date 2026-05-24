//
//  TokenStorage.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 18/5/26.
//

import Foundation
import Security

final class TokenStorage {
    static let shared = TokenStorage()
    private init() {}
    
    private let accessKey = "accessToken"
    private let refreshKey = "refreshToken"
    
    let service = "com.nutriquor.auth"
    
    // MARK: - Save
        func saveAccessToken(_ token: String) {
            save(token, key: accessKey)
        }

        func saveRefreshToken(_ token: String) {
            save(token, key: refreshKey)
        }

        // MARK: - Read
        func getAccessToken() -> String? {
            read(key: accessKey)
        }

        func getRefreshToken() -> String? {
            read(key: refreshKey)
        }

        // MARK: - Clear (Logout)
        func clearTokens() {
            delete(key: accessKey)
            delete(key: refreshKey)
        }

        // MARK: - Private wrapper
        private func save(_ value: String, key: String) {
            save(value, key: key, service: service)
        }

        private func read(key: String) -> String? {
            read(key: key, service: service)
        }

        private func delete(key: String) {
            delete(key: key, service: service)
        }
}
