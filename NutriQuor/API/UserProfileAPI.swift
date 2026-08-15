//
//  UserProfileAPI.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 25/5/26.
//

import Foundation

enum UserProfileAPI {
    
    // MARK: - Profile Information
    static func updateUserProfileRequest(profileId: String, firstName: String?, lastName: String?, avatar: String?) throws -> URLRequest {
        guard let url = URL(
            string: "\(AppConfig.shared.devBaseURL)/api/v1/user-profiles/\(profileId)"
        ) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        var body: [String: Any] = [:]
        if let firstName { body["first_name"] = firstName }
        if let lastName  { body["last_name"]  = lastName  }
        if let avatar    { body["avatar"]     = avatar    }
        
        request.httpBody = try JSONSerialization.data(withJSONObject: body)
        
        return request
    }
    
    static func familyMembersRequest(profileId: String) throws -> URLRequest {
        guard let url = URL(
            string: "\(AppConfig.shared.devBaseURL)/api/v1/user-profiles/family-members"
        ) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        return request
    }
    
    static func addFamilyMembersRequest(
        firstName: String?,
        lastName: String?,
        avatar: String?
    ) throws -> URLRequest {
        guard let url = URL(
            string: "\(AppConfig.shared.devBaseURL)/api/v1/user-profiles/family-members"
        ) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any?] = [
            "first_name": firstName,
            "last_name": lastName,
            "avatar": avatar
        ]

        request.httpBody = try JSONSerialization.data(withJSONObject: body)

        return request
    }
    
    static func deleteProfileRequest(
        profileId: String
    ) throws -> URLRequest {
        
        guard let url = URL(
            string: "\(AppConfig.shared.devBaseURL)/api/v1/user-profiles/\(profileId)"
        ) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"

        return request
    }
}
