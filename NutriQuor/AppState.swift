//
//  AppState.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 18/5/26.
//

import Foundation
import Combine
import SwiftUI

struct FullScreenDetailRoute: Identifiable {
    let id = UUID()
    let view: AnyView
}

@MainActor
final class AppState: ObservableObject {

    @Published var authState: AuthState = .loading
    @Published var selectedTab: Int = 0
    @Published private(set) var isBottomBarHidden = false
    @Published private(set) var fullScreenDetailStack: [FullScreenDetailRoute] = []
    @Published private(set) var scanHistoryRefreshToken = UUID()

    @Published var user: User?
    @Published var profile: Profile?

    private let hasLoggedInKey = "has_logged_in"
    private var bottomBarHiddenDepth = 0

    private var hasLoggedInBefore: Bool {
        UserDefaults.standard.bool(forKey: hasLoggedInKey)
    }

    private func setHasLoggedInBefore(_ value: Bool) {
        UserDefaults.standard.set(value, forKey: hasLoggedInKey)
    }

    func bootstrap() async {

        if TokenStorage.shared.getAccessToken() != nil, !hasLoggedInBefore {
            TokenStorage.shared.clearTokens()
            authState = .login
            return
        }

        if TokenStorage.shared.getAccessToken() != nil {
            await loadCurrentUser()
            return
        }

        if TokenStorage.shared.getRefreshToken() != nil {

            let refreshed = await AuthInterceptor.shared.refresh()

            if refreshed {
                await loadCurrentUser()
            } else if TokenStorage.shared.getRefreshToken() == nil {
                logout()
            } else {
                authState = .login
            }

            return
        }

        authState = .login
    }

    func loadCurrentUser() async {

        do {

            let me = try await AuthService.shared.getMe()

            self.user = me.data.user
            self.profile = me.data.profile

            self.selectedTab = 0
            self.authState = .loggedIn

        } catch APIError.unauthorized {
            if TokenStorage.shared.getRefreshToken() == nil {
                logout()
            } else {
                authState = .login
            }
        } catch {
            authState = .login
        }
    }

    func loginSuccess(
        accessToken: String,
        refreshToken: String
    ) async {

        authState = .loading
        TokenStorage.shared.saveAccessToken(accessToken)
        TokenStorage.shared.saveRefreshToken(refreshToken)
        setHasLoggedInBefore(true)

        await loadCurrentUser()
    }

    func logout() {

        TokenStorage.shared.clearTokens()
        setHasLoggedInBefore(false)

        user = nil
        profile = nil
        selectedTab = 0
        resetBottomBarVisibility()
        dismissAllFullScreenDetails()

        authState = .login
    }

    func pushBottomBarHidden() {
        bottomBarHiddenDepth += 1
        isBottomBarHidden = bottomBarHiddenDepth > 0
    }

    func popBottomBarHidden() {
        bottomBarHiddenDepth = max(0, bottomBarHiddenDepth - 1)
        isBottomBarHidden = bottomBarHiddenDepth > 0
    }

    func resetBottomBarVisibility() {
        bottomBarHiddenDepth = 0
        isBottomBarHidden = false
    }

    func pushFullScreenDetail<Content: View>(
        @ViewBuilder _ content: () -> Content
    ) {
        fullScreenDetailStack.append(
            FullScreenDetailRoute(view: AnyView(content()))
        )
    }

    func popFullScreenDetail() {
        guard !fullScreenDetailStack.isEmpty else { return }
        fullScreenDetailStack.removeLast()
    }

    func dismissAllFullScreenDetails() {
        fullScreenDetailStack.removeAll()
    }

    func notifyScanHistoryChanged() {
        scanHistoryRefreshToken = UUID()
    }
}
