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
            errorMessage = "Vui lòng nhập email."
            return
        }

        guard !password.isEmpty else {
            errorMessage = "Vui lòng nhập mật khẩu."
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

            await appState.loginSuccess(
                accessToken: response.data.accessToken,
                refreshToken: response.data.refreshToken
            )

        } catch {
            errorMessage = UserMessageMapper.message(for: error)
        }
    }
    
}
