//
//  AppState.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 18/5/26.
//

import Foundation
import Combine
//
//  AppState.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 18/5/26.
//

import Foundation
import Combine
@MainActor
final class AppState: ObservableObject {

    @Published var authState: AuthState = .loading

    @Published var user: User?
    @Published var profile: Profile?

    func bootstrap() async {

        guard TokenStorage.shared.getAccessToken() != nil else {
            authState = .login
            return
        }

        await loadCurrentUser()
    }

    func loadCurrentUser() async {

        do {

            let me = try await AuthService.shared.getMe()

            self.user = me.data.user
            self.profile = me.data.profile

            self.authState = .loggedIn

        } catch {
            print(error)
            logout()
        }
    }

    func loginSuccess(
        accessToken: String,
        refreshToken: String
    ) async {

        authState = .loading
        TokenStorage.shared.saveAccessToken(accessToken)
        TokenStorage.shared.saveRefreshToken(refreshToken)

        await loadCurrentUser()
    }

    func logout() {

        TokenStorage.shared.clearTokens()

        user = nil
        profile = nil

        authState = .login
    }
}
