//
//  Register.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 15/5/26.
//

import Foundation
import Combine

//extension RegisterViewModel {
//    
//    func setupValidation() {
//        
//        $firstName
//            .dropFirst()
//            .sink { [weak self] _ in
//                self?.firstName.isTouched = true
//                self?.validateFirstName()
//                self?.validateForm()
//            }
//            .store(in: &cancellables)
//        
//        
//        $lastName
//            .dropFirst()
//            .sink { [weak self] _ in
//                self?.lastName.isTouched = true
//                self?.validateLastName()
//                self?.validateForm()
//            }
//            .store(in: &cancellables)
//        
//        
//        $email
//            .dropFirst()
//            .sink { [weak self] _ in
//                self?.email.isTouched = true
//                self?.validateEmail()
//                self?.validateForm()
//            }
//            .store(in: &cancellables)
//        
//        
//        $password
//            .dropFirst()
//            .sink { [weak self] _ in
//                self?.password.isTouched = true
//                self?.validatePassword()
//                self?.validateConfirmPassword()
//                self?.validateForm()
//            }
//            .store(in: &cancellables)
//        
//        
//        $confirmPassword
//            .dropFirst()
//            .sink { [weak self] _ in
//                self?.confirmPassword.isTouched = true
//                self?.validateConfirmPassword()
//                self?.validateForm()
//            }
//            .store(in: &cancellables)
//    }
//}

// MARK: - Validation

extension RegisterViewModel {
    private func validateForm() {
        
        isFormValid =
        firstName.isValid &&
        lastName.isValid &&
        email.isValid &&
        password.isValid &&
        confirmPassword.isValid &&
        
        !firstName.value.isEmpty &&
        !lastName.value.isEmpty &&
        !email.value.isEmpty &&
        !password.value.isEmpty &&
        !confirmPassword.value.isEmpty
    }
    
    func validateFirstName() {

          if firstName.value.trimmingCharacters(in: .whitespaces).isEmpty {
              firstName.error = "First name is required"
              return
          }

          if !Validators.isValidName(firstName.value) {
              firstName.error = "Only letters allowed"
              return
          }

          firstName.error = nil
      }

      func validateLastName() {

          if lastName.value.trimmingCharacters(in: .whitespaces).isEmpty {
              lastName.error = "Last name is required"
              return
          }

          if !Validators.isValidName(lastName.value) {
              lastName.error = "Only letters allowed"
              return
          }

          lastName.error = nil
      }

      func validateEmail() {

          if email.value.isEmpty {
              email.error = "Email is required"
              return
          }

          if !Validators.isValidEmail(email.value) {
              email.error = "Invalid email"
              return
          }

          email.error = nil
      }

      func validatePassword() {

          if password.value.count < 6 {
              password.error = "Minimum 6 characters"
              return
          }

          password.error = nil
      }

      func validateConfirmPassword() {

          if confirmPassword.value.isEmpty {
              confirmPassword.error = "Confirm password required"
              return
          }

          if confirmPassword.value != password.value {
              confirmPassword.error = "Passwords do not match"
              return
          }

          confirmPassword.error = nil
      }
    
    func validate() {

        validateFirstName()
        validateLastName()
        validateEmail()
        validatePassword()
        validateConfirmPassword()
        isFormValid =
                firstName.error == nil &&
                lastName.error == nil &&
                email.error == nil &&
                password.error == nil &&
                confirmPassword.error == nil &&

                !firstName.value.isEmpty &&
                !lastName.value.isEmpty &&
                !email.value.isEmpty &&
                !password.value.isEmpty &&
                !confirmPassword.value.isEmpty
    }
}
