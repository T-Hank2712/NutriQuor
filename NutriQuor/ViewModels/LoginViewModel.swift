//
//  LoginViewModel.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 18/5/26.
//

import Foundation
import Combine

@MainActor
final class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""

    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var isSuccess: Bool = false
    
    private let appState: AppState
    
    init(appState: AppState){
        self.appState = appState
    }
    
    func login() async {
        
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Email is required"
            return
        }

        guard !password.isEmpty else {
            errorMessage = "Password is required"
            return
        }

        isLoading = true
        errorMessage = nil

        defer {
            isLoading = false
        }

        do {

            let response = try await AuthService.shared.login(
                email: email,
                password: password
            )

            TokenStorage.shared.saveAccessToken(
                response.data.accessToken
            )

            TokenStorage.shared.saveRefreshToken(
                response.data.refreshToken
            )
            isSuccess = true
            appState.isAuthenticated = true
            await appState.loadCurrentUser()
            print("Login Success")

        } catch {

            errorMessage = error.localizedDescription
            
            print(error.localizedDescription)
        }
    }
    
}
