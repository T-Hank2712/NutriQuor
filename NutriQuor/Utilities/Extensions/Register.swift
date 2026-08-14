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
              firstName.error = "Vui lòng nhập tên."
              return
          }

          if !Validators.isValidName(firstName.value) {
              firstName.error = "Tên chỉ được chứa chữ cái."
              return
          }

          firstName.error = nil
      }

      func validateLastName() {

          if lastName.value.trimmingCharacters(in: .whitespaces).isEmpty {
              lastName.error = "Vui lòng nhập họ."
              return
          }

          if !Validators.isValidName(lastName.value) {
              lastName.error = "Họ chỉ được chứa chữ cái."
              return
          }

          lastName.error = nil
      }

      func validateEmail() {

          if email.value.isEmpty {
              email.error = "Vui lòng nhập email."
              return
          }

          if !Validators.isValidEmail(email.value) {
              email.error = "Email không đúng định dạng."
              return
          }

          email.error = nil
      }

      func validatePassword() {

          if password.value.count < 6 {
              password.error = "Mật khẩu cần có ít nhất 6 ký tự."
              return
          }

          password.error = nil
      }

      func validateConfirmPassword() {

          if confirmPassword.value.isEmpty {
              confirmPassword.error = "Vui lòng nhập lại mật khẩu."
              return
          }

          if confirmPassword.value != password.value {
              confirmPassword.error = "Mật khẩu xác nhận chưa khớp."
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
