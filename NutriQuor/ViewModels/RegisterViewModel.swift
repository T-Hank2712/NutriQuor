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
    
    @Published var firstName = FormField()
    @Published var lastName = FormField()
    @Published var email = FormField()
    @Published var password = FormField()
    @Published var confirmPassword = FormField()
    
    @Published var isFormValid = false
    
    @Published var cancellables = Set<AnyCancellable>()
    
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var isSuccess: Bool = false
    
//    init(){
//        setupValidation()
//    }
    
    func register() async {
        validate()
        
        isLoading = true
        errorMessage = nil
        
        do {
            try await AuthService.shared.register(
                firstName: firstName.value,
                lastName: lastName.value,
                email: email.value,
                password: password.value,
                confirmPassword: confirmPassword.value
            )
            isSuccess = true
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}

struct FormField {
    var value: String = ""
    var error: String?
    var isTouched = false
    var isValid: Bool {
        error == nil
    }
}
