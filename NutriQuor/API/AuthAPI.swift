//
//  AuthAPI.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 24/5/26.
//

import Foundation

enum AuthAPI {

    static func registerRequest(
        firstName: String,
        lastName: String,
        email: String,
        password: String,
        confirmPassword: String
    ) throws -> URLRequest {

        guard let url = URL(
            string: "\(AppConfig.shared.devBaseURL)/api/v0/auth/register"
        ) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body = RegisterRequest(
            first_name: firstName,
            last_name: lastName,
            email: email,
            password: password,
            confirm_password: confirmPassword
        )

        request.httpBody = try JSONEncoder().encode(body)

        return request
    }

    static func loginRequest(email: String, password: String) throws -> URLRequest {
        guard let url = URL(
            string: "\(AppConfig.shared.devBaseURL)/api/v0/auth/login"
        ) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body = LoginRequest(email: email, password: password)
        request.httpBody = try JSONEncoder().encode(body)

        return request
    }

    static func meRequest() throws -> URLRequest {
        guard let url = URL(
            string: "\(AppConfig.shared.devBaseURL)/api/v0/user-profiles/me"
        ) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        return request
    }
    
    static func refreshAccessTokenRequest(refreshToken: String) throws -> URLRequest {
        var components = URLComponents(
            string: "\(AppConfig.shared.devBaseURL)/api/v0/auth/refresh"
        )
        components?.queryItems = [
            URLQueryItem(name: "refresh_token", value: refreshToken)
        ]

        guard let url = components?.url else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        return request
    }
}
