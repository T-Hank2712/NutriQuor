//
//  RegisterView.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 14/5/26.
//

import SwiftUI

struct RegisterView: View {
    
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        GeometryReader { geo in
            
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
                
                ScrollView(showsIndicators: false) {
                    
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
                                            title: "First Name",
                                            placeholder: "Jane",
                                            icon: "person",
                                            text: $firstName
                                        )
                                        
                                        InputField(
                                            title: "Last Name",
                                            placeholder: "Doe",
                                            icon: "person.text.rectangle",
                                            text: $lastName
                                        )
                                        
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
                                        
                                        InputField(
                                            title: "Confirm Password",
                                            placeholder: "Confirm Password",
                                            icon: "lock",
                                            text: $password
                                        )
                                    }
                                    .padding(.top, 10)
                                    
                                    SubmitButton(title: "Sign Up")
                                    
                                    HStack(spacing: 4) {
                                                
                                                Text("Already have an account?")
                                                    .foregroundStyle(.gray)
                                                
                                                Button("Log in") {
                                                    
                                                }
                                                .foregroundStyle(Color(.heading))
                                                .fontWeight(.semibold)
                                            }
                                            .font(.system(size: 18))
                                            .padding(.bottom, 20)
                                }
                                .padding()
                            }
                            .frame(minHeight: geo.size.height - 10)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 70)
                    }.padding(.bottom, 50)
                }
            }
        }
    }
}


#Preview {
    RegisterView()
}
