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
            string: "\(AppConfig.shared.devBaseURL)/api/v0/allergies"
        ) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        return request
    }

    static func diseasesRequest() throws -> URLRequest {
        guard let url = URL(
            string: "\(AppConfig.shared.devBaseURL)/api/v0/diseases"
        ) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        return request
    }

    static func healthGoalsRequest() throws -> URLRequest {
        guard let url = URL(
            string: "\(AppConfig.shared.devBaseURL)/api/v0/health-goals"
        ) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        return request
    }

    static func healthGoalProfileRequest(profileId: Int) throws -> URLRequest {
        guard let url = URL(
            string: "\(AppConfig.shared.devBaseURL)/api/v0/user-profiles/\(profileId)/health-goals"
        ) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        return request
    }

    static func addHealthGoalRequest(
        profileId: Int,
        healthGoalId: Int
    ) throws -> URLRequest {
        guard let url = URL(
            string: "\(AppConfig.shared.devBaseURL)/api/v0/user-profiles/\(profileId)/health-goals/\(healthGoalId)"
        ) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        return request
    }

    static func deleteHealthGoalRequest(
        profileId: Int,
        healthGoalId: Int
    ) throws -> URLRequest {
        guard let url = URL(
            string: "\(AppConfig.shared.devBaseURL)/api/v0/user-profiles/\(profileId)/health-goals/\(healthGoalId)"
        ) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"

        return request
    }

    static func diseaseProfileRequest(profileId: Int) throws -> URLRequest {
        guard let url = URL(
            string: "\(AppConfig.shared.devBaseURL)/api/v0/user-profiles/\(profileId)/diseases"
        ) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        return request
    }

    static func addDiseaseRequest(
        profileId: Int,
        diseaseId: Int
    ) throws -> URLRequest {
        guard let url = URL(
            string: "\(AppConfig.shared.devBaseURL)/api/v0/user-profiles/\(profileId)/diseases/\(diseaseId)"
        ) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        return request
    }

    static func deleteDiseaseRequest(
        profileId: Int,
        diseaseId: Int
    ) throws -> URLRequest {
        guard let url = URL(
            string: "\(AppConfig.shared.devBaseURL)/api/v0/user-profiles/\(profileId)/diseases/\(diseaseId)"
        ) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"

        return request
    }

    static func allergyProfileRequest(profileId: Int) throws -> URLRequest {
        guard let url = URL(
            string: "\(AppConfig.shared.devBaseURL)/api/v0/user-profiles/\(profileId)/allergies"
        ) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        return request
    }

    static func addAllergyRequest(
        profileId: Int,
        allergyId: Int
    ) throws -> URLRequest {
        guard let url = URL(
            string: "\(AppConfig.shared.devBaseURL)/api/v0/user-profiles/\(profileId)/allergies/\(allergyId)"
        ) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        return request
    }

    static func deleteAllergyRequest(
        profileId: Int,
        allergyId: Int
    ) throws -> URLRequest {
        guard let url = URL(
            string: "\(AppConfig.shared.devBaseURL)/api/v0/user-profiles/\(profileId)/allergies/\(allergyId)"
        ) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"

        return request
    }
    
    // MARK: - Profile Information
    static func updateUserProfile(profileId: Int, firstName: String?, lastName: String?, avatar: String?) throws -> URLRequest {
        guard let url = URL(
            string: "\(AppConfig.shared.devBaseURL)/api/v0/user-profiles/\(profileId)"
        ) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        
        return request
    }
}
