//
//  AuthService.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 14/5/26.
//

import Foundation

final class AuthService{
    static let shared = AuthService()
    
    private init() {}
    
    func register(
        firstName: String,
        lastName: String,
        email: String,
        password: String,
        confirmPassword: String
    ) async throws {
        
        guard let url = URL(
            string: "http://127.0.0.1:8000/api/v0/auth/register"
        ) else {
            throw URLError(.badURL)
        }
        
        let body = RegisterRequest(
            first_name: firstName,
            last_name: lastName,
            email: email,
            password: password,
            confirm_password: confirmPassword
        )
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        
        request.setValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )
        
        request.httpBody = try JSONEncoder().encode(body)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        
        print("STATUS:", httpResponse.statusCode)
        
        print(
            String(data: data, encoding: .utf8) ?? "EMPTY RESPONSE"
        )
        
        guard 200...299 ~= httpResponse.statusCode else {
            
            let message = String(data: data, encoding: .utf8)
            
            throw NSError(
                domain: "",
                code: httpResponse.statusCode,
                userInfo: [
                    NSLocalizedDescriptionKey:
                        message ?? "Register failed"
                ]
            )
        }
    }
}
