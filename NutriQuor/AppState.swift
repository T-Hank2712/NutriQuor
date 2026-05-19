//
//  AppState.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 18/5/26.
//

import Foundation
import Combine
final class AppState: ObservableObject {
    @Published var showSplash: Bool = true
    @Published var isLoggedIn: Bool = false
    @Published var authState: AuthState = .login
    
    @Published var isAuthenticated: Bool = false
    @Published var user: User? = nil
    @Published var profile: Profile? = nil
    
    func loginSuccess(
        accessToken: String,
        refreshToken: String,
        user: User,
        profile: Profile
    ) {
        // lưu vào Keychain
        TokenStorage.shared.saveAccessToken(accessToken)
        TokenStorage.shared.saveRefreshToken(refreshToken)
        
        // update UI state
        self.user = user
        self.profile = profile
        self.isLoggedIn = true
    }
    
    func loadSession() {
        let access = TokenStorage.shared.getAccessToken()
        
        if access != nil {
            self.isLoggedIn = true
            authState = .loggedIn
        } else {
            self.isLoggedIn = false
        }
    }
    func loadCurrentUser() async {
        guard TokenStorage.shared.getAccessToken() != nil else {
            authState = .login
            return
        }
        
        do {
            let me = try await AuthService.shared.getMe()
            
                self.user = me.user
                self.profile = me.profile
                self.isAuthenticated = true
                self.authState = .loggedIn
            
        } catch {
            authState = .login
        }
    }
    func logout() {
           
           TokenStorage.shared.clearTokens()
           
           user = nil
           
           profile = nil
           
           isAuthenticated = false
       }
}
