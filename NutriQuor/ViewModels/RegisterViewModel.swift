//
//  RegisterViewModel.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 14/5/26.
//

import Foundation
import Combine

@MainActor

final class RegisterViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var isSuccess: Bool = false
    func register(
        firstName: String,
        lastName: String,
        email: String,
        password: String,
        confirmPassword: String
    ) async {
        isLoading = true
        errorMessage = nil
        do {
            let response = try await AuthService.shared.register(
                firstName: firstName,
                lastName: lastName,
                email: email,
                password: password,
                confirmPassword: confirmPassword
            )
            
            isSuccess = true
            print(response)
            
        } catch {
            print(error.localizedDescription)
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
}
