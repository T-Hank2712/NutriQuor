//
//  LoginView.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 14/5/26.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject private var viewModel: LoginViewModel
    @EnvironmentObject var appState: AppState
    
    init(appState: AppState) {
        _viewModel = StateObject(wrappedValue: LoginViewModel(appState: appState))
    }
    var body: some View {
        
        NavigationStack{
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
                
                VStack {
                    
                    RoundedRectangle(cornerRadius: .cardRadius)
                        .fill(Color(.systemBackground).opacity(0.92))
                        .overlay {
                            
                            VStack(spacing: 24) {
                                
                                VStack(spacing: 24) {
                                    
                                    ZStack {
                                        
                                        Circle()
                                            .fill(Color(.colorPrimary).opacity(0.5))
                                            .frame(width: 100, height: 100)
                                        
                                        Image(systemName: "heart")
                                            .font(
                                                .system(
                                                    size: 38,
                                                    weight: .medium
                                                )
                                            )
                                            .foregroundStyle(Color(.heading))
                                    }
                                    
                                    Text("Know What’s In Your Food")
                                        .font(.heading1)
                                        .foregroundStyle(Color(.heading))
                                        .multilineTextAlignment(.center)
                                }
                                
                                VStack(spacing: 24) {
                                    
                                    InputField(
                                        title: "Email",
                                        placeholder: "jane@example.com",
                                        icon: "envelope",
                                        text: $viewModel.email
                                    )
                                    
                                    SecureInputField(
                                        title: "Password",
                                        placeholder: "Password",
                                        icon: "lock",
                                        text: $viewModel.password
                                    )
                                }
                                .padding(.top, 10)
                                
                                if let error = viewModel.errorMessage {
                                    Text(error)
                                        .foregroundStyle(.red)
                                        .font(.subheadline)
                                }
                                
                                SubmitButton(
                                     title: viewModel.isLoading ? "Loading..." : "Log in"
                                 ) {
                                     Task {
                                         await viewModel.login()
                                     }
                                 }
                                 .disabled(viewModel.isLoading)
                                
                                HStack(spacing: 4) {
                                    
                                    Text("Don't have an account?")
                                        .foregroundStyle(.gray)
                                    
                                    Button {
                                        appState.authState = .register
                                    } label: {
                                        Text("Sign Up")
                                            .fontWeight(.semibold)
                                            .foregroundStyle(Color(.heading))
                                    }
                                }
                                .font(.system(size: 18))
                                .padding(.bottom, 20)
                            }
                            .padding()
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 70)
                }
                .padding(.bottom, 50)
            }
        }
    }
}

#Preview {
    let appState = AppState()

    return LoginView(appState: appState)
        .environmentObject(appState)
}
