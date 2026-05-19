//
//  RegisterView.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 14/5/26.
//

import SwiftUI

struct RegisterView: View {
    
    @StateObject private var viewModel = RegisterViewModel()
    @EnvironmentObject var appState: AppState
    @State private var showSuccessAlert = false
    @State private var navigateToLogin = false
    
    var body: some View {
        
        GeometryReader { geo in
            
            ZStack {
                
                LinearGradient(
                    colors: [
                        Color(.colorPrimary),
                        Color(.colorPrimary).opacity(0.05),
                        Color.blue.opacity(0.15)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    
                    VStack {
                        
                        RoundedRectangle(cornerRadius: 50)
                            .fill(Color(.systemBackground).opacity(0.4))
                            .overlay {
                                
                                VStack {
                                    
                                    VStack {
                                        
                                        ZStack {
                                            
                                            Circle()
                                                .fill(Color(.colorPrimary).opacity(0.5))
                                                .frame(width: 100, height: 100)
                                                .shadow(
                                                    color: .colorPrimary.opacity(0.25),
                                                    radius: 10
                                                )
                                            
                                            Image(systemName: "heart")
                                                .font(
                                                    .system(
                                                        size: 38,
                                                        weight: .medium
                                                    )
                                                )
                                                .foregroundStyle(Color(.heading))
                                        }
                                        .padding(.top, 20)
                                        
                                        Text("Know What’s In Your Food")
                                            .font(.heading1)
                                            .foregroundStyle(Color(.heading))
                                            .multilineTextAlignment(.center)
                                            .frame(maxWidth: .infinity)
                                            .lineLimit(nil)
                                            .fixedSize(horizontal: false, vertical: true)
                                            .padding(.bottom, 2)
                                    }
                                    
                                    VStack(spacing: 24) {
                                        
                                        VStack(alignment: .leading, spacing: 6) {

                                            InputField(
                                                title: "First Name",
                                                placeholder: "Jane",
                                                icon: "person",
                                                text: $viewModel.firstName.value
                                            )

                                            if let error = viewModel.firstName.error {

                                                Text(error)
                                                    .font(.caption)
                                                    .foregroundStyle(.red)
                                                    .padding(.leading, 4)
                                            }
                                        }
                                        
                                        VStack(alignment: .leading, spacing: 6) {

                                            InputField(
                                                title: "Last Name",
                                                placeholder: "Doe",
                                                icon: "person.text.rectangle",
                                                text: $viewModel.lastName.value
                                            )

                                            if let error = viewModel.lastName.error {

                                                Text(error)
                                                    .font(.caption)
                                                    .foregroundStyle(.red)
                                                    .padding(.leading, 4)
                                            }
                                        }
                                        
                                        VStack(alignment: .leading, spacing: 6) {

                                            InputField(
                                                title: "Email",
                                                placeholder: "jane@example.com",
                                                icon: "envelope",
                                                text: $viewModel.email.value
                                            )

                                            if let error = viewModel.email.error {

                                                Text(error)
                                                    .font(.caption)
                                                    .foregroundStyle(.red)
                                                    .padding(.leading, 4)
                                            }
                                        }
                                        
                                        VStack(alignment: .leading, spacing: 6) {

                                            SecureInputField(
                                                title: "Password",
                                                placeholder: "Password",
                                                icon: "lock",
                                                text: $viewModel.password.value
                                            )

                                            if let error = viewModel.password.error {

                                                Text(error)
                                                    .font(.caption)
                                                    .foregroundStyle(.red)
                                                    .padding(.leading, 4)
                                            }
                                        }
                                        
                                        VStack(alignment: .leading, spacing: 6) {

                                            SecureInputField(
                                                title: "Confirm Password",
                                                placeholder: "Confirm Password",
                                                icon: "lock",
                                                text: $viewModel.confirmPassword.value
                                            )

                                            if let error = viewModel.confirmPassword.error {

                                                Text(error)
                                                    .font(.caption)
                                                    .foregroundStyle(.red)
                                                    .padding(.leading, 4)
                                            }
                                        }
                                    }
                                    
                                    ZStack {
                                        
                                        SubmitButton(title: "Sign Up") {

                                            Task {
                                                await viewModel.register()

                                                await MainActor.run {
                                                    if viewModel.isSuccess {
                                                        showSuccessAlert = true
                                                    }
                                                }
                                            }
                                        }
                                        .disabled(viewModel.isLoading)
                                        
                                        if viewModel.isLoading {
                                            ProgressView()
                                        }
                                    }
                                    
                                    if let error = viewModel.errorMessage {
                                        Text(error)
                                            .foregroundStyle(.red)
                                            .font(.system(size: 14))
                                            .multilineTextAlignment(.center)
                                    }
                                    
                                    HStack(spacing: 4) {
                                        
                                        Text("Already have an account?")
                                            .foregroundStyle(.gray)
                                        
                                        Button {
                                            DispatchQueue.main.async {
                                                appState.authState = .login
                                            }
                                        } label: {
                                            Text("Log in")
                                                .fontWeight(.semibold)
                                                .foregroundStyle(Color(.heading))
                                        }
                                    }
                                    .font(.system(size: 18))
                                    .padding(.bottom, 20)
                                }
                                .padding(.horizontal, 20)
                            }
                            .frame(minHeight: geo.size.height + 200)
                            .padding(.horizontal, 20)
                    }
                    .padding(.bottom, 50)
                }
            }
        }
        .alert(
            "Register Successfully",
            isPresented: $showSuccessAlert
        ) {
        } message: {
            Text("Redirecting to login...")
        }
        .onChange(of: viewModel.isSuccess) {
            if viewModel.isSuccess {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    appState.authState = .login
                }
            }
        }
        .onChange(of: viewModel.firstName.value) {
            viewModel.validateFirstName()
        }

        .onChange(of: viewModel.lastName.value) {
            viewModel.validateLastName()
        }

        .onChange(of: viewModel.email.value) {
            viewModel.validateEmail()
        }

        .onChange(of: viewModel.password.value) {
            viewModel.validatePassword()
            viewModel.validateConfirmPassword()
        }

        .onChange(of: viewModel.confirmPassword.value) {
            viewModel.validateConfirmPassword()
        }
    }
}

#Preview {
    RegisterView()
}
