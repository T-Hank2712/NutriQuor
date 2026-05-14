//
//  LoginView.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 14/5/26.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(.primary),
                    Color(.primary).opacity(0.05),
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
                                        .fill(Color(.primary).opacity(0.5))
                                        .frame(width: 100, height: 100)
                                        .shadow(
                                            color: .pink.opacity(0.25),
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
                            }
                            
                            VStack(spacing: 24) {
                                
                                InputField(
                                    title: "Email",
                                    placeholder: "jane@example.com",
                                    icon: "envelope",
                                    text: $email
                                )
                                
                                InputField(
                                    title: "Password",
                                    placeholder: "Password",
                                    icon: "lock",
                                    text: $password
                                )
                            }
                            .padding(.top, 10)
                            
                            SubmitButton(title: "Log in")
                            
                            HStack(spacing: 4) {
                                        
                                        Text("Don't have an account?")
                                            .foregroundStyle(.gray)
                                        
                                        Button("Sign Up") {
                                            
                                        }
                                        .foregroundStyle(Color(.heading))
                                        .fontWeight(.semibold)
                                    }
                                    .font(.system(size: 18))
                                    .padding(.bottom, 20)
                        }
                        .padding()
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 70)
            }.padding(.bottom, 50)

        }
    }
}

#Preview {
    LoginView()
}
