//
//  UserProfileAPI.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 25/5/26.
//

import Foundation

enum UserProfileAPI {

    static func allergiesRequest() throws -> URLRequest {
        guard let url = URL(
            string: "\(AppConfig.shared.devBaseURL)/api/v1/allergies"
        ) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        return request
    }

    static func diseasesRequest() throws -> URLRequest {
        guard let url = URL(
            string: "\(AppConfig.shared.devBaseURL)/api/v1/diseases"
        ) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        return request
    }

    static func healthGoalsRequest() throws -> URLRequest {
        guard let url = URL(
            string: "\(AppConfig.shared.devBaseURL)/api/v1/health-goals"
        ) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        return request
    }

    static func healthGoalProfileRequest(profileId: String) throws -> URLRequest {
        guard let url = URL(
            string: "\(AppConfig.shared.devBaseURL)/api/v1/user-profiles/\(profileId)/health-goals"
        ) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        return request
    }

    static func addHealthGoalRequest(
        profileId: String,
        healthGoalId: Int
    ) throws -> URLRequest {
        guard let url = URL(
            string: "\(AppConfig.shared.devBaseURL)/api/v1/user-profiles/\(profileId)/health-goals/\(healthGoalId)"
        ) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        return request
    }

    static func deleteHealthGoalRequest(
        profileId: String,
        healthGoalId: Int
    ) throws -> URLRequest {
        guard let url = URL(
            string: "\(AppConfig.shared.devBaseURL)/api/v1/user-profiles/\(profileId)/health-goals/\(healthGoalId)"
        ) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"

        return request
    }

    static func diseaseProfileRequest(profileId: String) throws -> URLRequest {
        guard let url = URL(
            string: "\(AppConfig.shared.devBaseURL)/api/v1/user-profiles/\(profileId)/diseases"
        ) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        return request
    }

    static func addDiseaseRequest(
        profileId: String,
        diseaseId: Int
    ) throws -> URLRequest {
        guard let url = URL(
            string: "\(AppConfig.shared.devBaseURL)/api/v1/user-profiles/\(profileId)/diseases/\(diseaseId)"
        ) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        return request
    }

    static func deleteDiseaseRequest(
        profileId: String,
        diseaseId: Int
    ) throws -> URLRequest {
        guard let url = URL(
            string: "\(AppConfig.shared.devBaseURL)/api/v1/user-profiles/\(profileId)/diseases/\(diseaseId)"
        ) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"

        return request
    }

    static func allergyProfileRequest(profileId: String) throws -> URLRequest {
        guard let url = URL(
            string: "\(AppConfig.shared.devBaseURL)/api/v1/user-profiles/\(profileId)/allergies"
        ) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        return request
    }

    static func addAllergyRequest(
        profileId: String,
        allergyId: Int
    ) throws -> URLRequest {
        guard let url = URL(
            string: "\(AppConfig.shared.devBaseURL)/api/v1/user-profiles/\(profileId)/allergies/\(allergyId)"
        ) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        return request
    }

    static func deleteAllergyRequest(
        profileId: String,
        allergyId: Int
    ) throws -> URLRequest {
        guard let url = URL(
            string: "\(AppConfig.shared.devBaseURL)/api/v1/user-profiles/\(profileId)/allergies/\(allergyId)"
        ) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"

        return request
    }
    
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
            string: "\(AppConfig.shared.devBaseURL)/api/v1/user-profiles/\(profileId)/family-members"
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
