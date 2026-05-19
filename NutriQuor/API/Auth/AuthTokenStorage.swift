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
    
    let service = "com.nutriquor.auth"
    
    func saveAccessToken(
            _ token: String
        ) {
            save(
                token,
                key: "accessToken"
            )
        }
        
    func saveRefreshToken(
        _ token: String
    ) {
        save(
            token,
            key: "refreshToken"
        )
    }
    
    func getAccessToken() -> String? {
        read(key: "accessToken")
    }
    
    func getRefreshToken() -> String? {
        read(key: "refreshToken")
    }
    
    func clearTokens() {
        
        delete(key: "accessToken")
        
        delete(key: "refreshToken")
    }
}
